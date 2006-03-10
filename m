Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWCJNgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWCJNgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWCJNgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:36:45 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:6625 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751017AbWCJNgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:36:43 -0500
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
In-Reply-To: Your message of "Fri, 10 Mar 2006 14:46:29 +0800."
             <3ACA40606221794F80A5670F0AF15F840B280323@pdsmsx403> 
Date: Fri, 10 Mar 2006 13:36:40 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FHhnM-0002kR-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, there's no point only attaching it at bugzilla, since the
relevant output is shorter than I thought:

/proc/cmdline: auto BOOT_IMAGE=16-rc5 ro root=305 idebus=66 apm=off acpi=force pci=noacpi console=ttyS0,115200 console=tty0 acpi_sleep=s3_bios cpufreq.debug=7 acpi_debug=0xffffffff

where 16-rc5 is my LILO label for 2.6.16-rc5

The extract from the dmesgs:

Stopping tasks: ========================================================|
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFF40
 acpi_ec-0458 [37] ec_intr_read          : Read [02] from address [32]
 acpi_ec-0508 [37] ec_intr_write         : Wrote [06] to address [32]
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
Execute Method: [\_S3_] (Node c157a988)
exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFF40
Execute Method: [\_PTS] (Node c157ab48)
exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFF40
exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFF40
exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFF40
exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0
exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 width) Address=0000000023FDFFC0
exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC4
exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 width) Address=0000000023FDFFC4
exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0
exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 width) Address=00000000000000B2
exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0
exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0
exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 width) Address=0000000023FDFFC0
exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 width) Address=00000000000000B2

And then these above four lines (exregion-0185, -0185, -0185, -0290)
repeat until I reboot.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
