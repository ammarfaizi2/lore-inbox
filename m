Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272055AbTG2UBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272129AbTG2UBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:01:43 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:24452 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S272055AbTG2T6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:58:34 -0400
Subject: [2.6.0-test-ac3] ACPI + sensors => health chip flatlines
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059508734.16839.18.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 22:58:54 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This has happened twice now. I have the following in my kernel log:

acpi_power-0377 [25] acpi_power_transition : Error transitioning device [FAN] to D0
acpi_bus-0256 [24] acpi_bus_set_power    : Error transitioning device [FAN] to D0
acpi_thermal-0611 [23] acpi_thermal_active   : Unable to turn cooling device [c1be7d34] 'on'

Everything under /sys/devices/legacy/i2c-1/1-0290 is frozen to the same
values, none of the sensors are being updated. 

Not quite sure what is going on but it looks like an ACPI thermal trip
routine might be messing up the W83627HF sensor driver.

	MikaL

