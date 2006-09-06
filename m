Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWIFKhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWIFKhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWIFKhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:37:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31374 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750770AbWIFKhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:37:22 -0400
Date: Wed, 6 Sep 2006 12:37:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jim Gettys <jg@laptop.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Message-ID: <20060906103725.GA4987@atrey.karlin.mff.cuni.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com> <20060830194317.GA9116@srcf.ucam.org> <200608311713.21618.bjorn.helgaas@hp.com> <1157070616.7974.232.camel@localhost.localdomain> <20060904130933.GC6279@ucw.cz> <1157466710.6011.262.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157466710.6011.262.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 2.4 and 2.6 are *very* different here. You'll probably need to optimize freezer
> > in 2.6 a bit...
> > 						
> 
> Among other problems: e.g. 2.4 did not automatically do a VT switch; 2.6
> does; we'll have to have a way to signal "we're a sane display driver;
> don't switch away from me on suspend".

Not like that, please.

You are using X running over framebuffer, right? So that kernel is
controlling the graphics hardware. In such case it is safe to avoid VT
switch.
									Pavel
-- 
Thanks, Sharp!
