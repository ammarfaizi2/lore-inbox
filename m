Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272235AbTG3Uao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272236AbTG3Uao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:30:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58891 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272235AbTG3Uan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:30:43 -0400
Date: Wed, 30 Jul 2003 22:07:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test-ac3] ACPI + sensors => health chip flatlines
Message-ID: <20030730200743.GI2601@openzaurus.ucw.cz>
References: <1059508734.16839.18.camel@hades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059508734.16839.18.camel@hades>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> acpi_power-0377 [25] acpi_power_transition : Error transitioning device [FAN] to D0
> acpi_bus-0256 [24] acpi_bus_set_power    : Error transitioning device [FAN] to D0
> acpi_thermal-0611 [23] acpi_thermal_active   : Unable to turn cooling device [c1be7d34] 'on'
> 
> Everything under /sys/devices/legacy/i2c-1/1-0290 is frozen to the same
> values, none of the sensors are being updated. 
> 
> Not quite sure what is going on but it looks like an ACPI thermal trip
> routine might be messing up the W83627HF sensor driver.

It probably is :-(. Either use acpi or w8xxxxHF, but not both.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

