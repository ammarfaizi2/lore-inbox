Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWEWRNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWEWRNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWEWRNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:13:13 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:31945 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750811AbWEWRNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:13:12 -0400
To: "Yu, Luming" <luming.yu@intel.com>
cc: trenn@suse.de, linux-kernel@vger.kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Tom Seeley" <redhat@tomseeley.co.uk>, "Dave Jones" <davej@redhat.com>,
       "Jiri Slaby" <jirislaby@gmail.com>, michael@mihu.de,
       mchehab@infradead.org, "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>,
       "Carl-Daniel Hailfinger" <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Tue, 23 May 2006 21:29:36 +0800."
             <554C5F4C5BA7384EB2B412FD46A3BAD11206E3@pdsmsx411.ccr.corp.intel.com> 
Date: Tue, 23 May 2006 18:12:53 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FiaRB-00085Y-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Trimmed lists that seemed unrelated: v4l-dvb-maintainer@linuxtv.org,
 video4linux-list@redhat.com, linux-usb-devel@lists.sourceforge.net,
 linux-ide@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz]

> But this Samsung P35 don't have _GLK. So, I think TP 600x has
> a different problem with Samsung P35.

You're right.  I tried 2.6.16.18, which has the smbus patch, but it
didn't help the resume.  I need to test more whether it helps the fan,
but I doubt it will.

2.6.17-rc4 (with vanilla DSDT) does strange things to the fan.  At
boot, the fan is often on.  The trip point is 37 C (the DSDT default)
and temperature, say, 40 C.  That's fine and the fan should be on.
But if I set the trip point to 45 C and the poll interval to 100
seconds, the fan remains on.  I have to set the trip point and polling
interval a second time for the fan to turn off.  With 2.6.16-rc5, it
would turn off after the first setting.

Also, and I need to check which kernel it is (either 2.6.16.18 or
2.6.17-rc4), during S3 sleep, the right speaker made a quiet hiss.  I
imagine that will run down the battery pretty quickly.  It's a new
behavior since 2.6.16-rc5.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
