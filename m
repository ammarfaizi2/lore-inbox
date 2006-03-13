Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWCMPVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWCMPVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCMPVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:21:15 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:25809 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932114AbWCMPVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:21:13 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Mon, 13 Mar 2006 16:35:45 +0800."
             <3ACA40606221794F80A5670F0AF15F840B2DB21B@pdsmsx403> 
Date: Mon, 13 Mar 2006 15:21:10 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FIor8-0002Rj-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, could you file dmesgs with thermal module loaded and unloaded?

Filed at bugzilla.

> I saw this acpi_debug=0xffffffff.

Sorry, it's a legacy from trying to debug #5112, and I've removed it
for getting the above dmesgs.  I'm not even sure what that option does
since it's not documented in the kernel-parameters.txt, but it does
increase the amount of debugging info.

> I used to used to use acpi_debug_layer=0x10 acpi_debug_level=0x10
> Could you try that?

For the above dmesgs I booted with acpi_dbg_level=0x10
acpi_dbg_layer=0x10 and then did two sleep-wake cycles with no thermal
module (both went fine), then one cycle with the thermal module loaded
(went fine), and then the usual failing second sleep with the thermal
module still loaded.  The sleep-wake cycles themselves (i.e. once the
system booted) were done with acpi_debug_level=0x1F rather than the
0x10 boot value.

Let me know if there's a different permutation of debug options that I
should try.  I wasn't sure whether you meant that I should leave all
the debug values at 0x10.  Or whether I should still include
acpi_debug=0xffffffff on top of the other options.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
