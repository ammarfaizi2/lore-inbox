Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUEMQ0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUEMQ0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 12:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUEMQ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 12:26:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38335 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264296AbUEMQ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 12:26:44 -0400
Date: Thu, 13 May 2004 18:26:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.ork.uk
Subject: Re: [PATCH] Powernow-k8 buggy BIOS override for 2.6.6
Message-ID: <20040513162643.GA4506@atrey.karlin.mff.cuni.cz>
References: <20040512235623.GA9234@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512235623.GA9234@atomide.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Following is the updated patch to make the powernow-k8 driver work on 
> machines with buggy BIOS, such as emachines m6805.
> 
> The patch overrides the PST table only if check_pst_table() fails.
> 
> The minimum value for the override is 800MHz, which is the lowest value 
> on all x86_64 systems AFAIK. The max value is the current running value.
> 
> This patch should be safe to apply, even if Pavel's ACPI table check is
> added to the driver. Or does anybody see a problem with it?

Well, there may be problems with that.

BIOSen sometimes run cpu at too high voltage. Plus, for changing
frequency you need to run at even higher voltage... and that may be
too high.

Is there some problem with ACPI on your system?
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
