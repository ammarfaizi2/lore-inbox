Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUATLFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUATLFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:05:39 -0500
Received: from [195.219.3.158] ([195.219.3.158]:23566 "EHLO oxtel.com")
	by vger.kernel.org with ESMTP id S265351AbUATLFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:05:37 -0500
Message-ID: <400D0B80.2000402@oxtel.com>
Date: Tue, 20 Jan 2004 11:05:36 +0000
From: Joe Rutledge <joe.rutledge@oxtel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.1 - SiI 3112 & Asus MBoard & WD Raptor cause complete hang with DMA and heavy load
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Server: VPOP3 Enterprise V2.0.0h - Registered
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Initially using a Seagate SATA drive I was experiencing random lockups, 
no kernel
panic just a complete hang. Having read about issues with DMA and some 
Seagates
I replaced the drive with a Western Digital Raptor. However I still see 
the same
lockups. I've tried a variety of options to hdparm (based around -X70 
-d1) none
of them making any difference to stability. I then swapped to the libata 
driver
expecting this to be more solid. It does appear to last a little longer 
than the
IDE driver but the same problems manifest themselves. I then found that 
there
were potentially some problems with the Asus board and shared interrupt 
lines to
the SiI3112 so I upgraded the BIOS to the most recent version (1007). 
This has
made no difference whatsoever. I also read that APIC and ACPI support could
exascerbate this problem so I removed them from the kernel and disabled 
them in
the BIOS. This has given better stability but still not to the point of 
a usable
system. This is a desktop system and it will become locked if any heavy 
disk
access is done. At the moment I'm running in PIO mode as this is the 
only stable
way of handling the disk. I'm not doing any RAID and have no need to. 
Merely a boot
of my 2.6.1/2.6.0/2.4.24 system to runlevel 1 and then running bonnie++ 
-u nobody
will guarantee a hang before all the write checks have been completed.

Asus A7N8X Deluxe (nforce2) BIOS V1007, AMD Athlon XP (Barton) 2800+, 
1GB DDR
RAM (2 x 512 as Dual Channel), WD Raptor 36G SATA HD, Asus GeForce FX 5600
(256MB), Lite-On 52x CDRW, DVD-ROM. Fresh Gentoo build optimised for 
Athlon-XP
(GCC 3.2.3 -march athlon-xp).

2.6.1 kernel patched for forcedeth and nvidia graphics card. APIC & ACPI 
support
removed from kernel and turned off in BIOS. Both the IDE and libata 
drivers have
been built into the kernel at separate times. It makes no difference 
what other
applications are running.

I'm not on the list so a copy of anything posted would be much appreciated.

Thanks in advance to everyone working on the kernel - excellent stuff, 
it's been
my working environment for years and a happy one at that!

Joe

