Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315616AbSFOWWA>; Sat, 15 Jun 2002 18:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSFOWV7>; Sat, 15 Jun 2002 18:21:59 -0400
Received: from ares.kos.net ([199.246.2.117]:35225 "HELO ares.kos.net")
	by vger.kernel.org with SMTP id <S315616AbSFOWV6>;
	Sat, 15 Jun 2002 18:21:58 -0400
Message-ID: <003101c214bb$0275a720$0a00000a@kos.net>
From: "Steve Cole" <coles@vip.kos.net>
To: <linux-kernel@vger.kernel.org>
Subject: Dual Athlon 2000 XP MP nightmare
Date: Sat, 15 Jun 2002 18:21:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-BlackHole: Version 0.9.83 by Chris Kennedy (C) 2002
X-BlackHole-Sender: (null)
X-BlackHole-Relay: 199.246.3.1
X-BlackHole-Match: No Match
X-BlackHole-Info: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'm not sure that what I'm experiencing is a kernel problem, but I thought
I  would stick my foot in the door nonetheless, since I have no real
indication of what is going on.

I have a dual Athlon 2000+ XP MP system.  It's crashing very frequently and
looks to be getting worse.  It seems to crash less with 2.4.19pre10-ac2
which supports the 760 bus and 744x IDE controller, but with something that
is as intermittent as this, who can tell?

Machine specs:

 ASUS A7M266-D motherboard, 1006 BIOS rev.
 2GB ECC registered memory
 4 x 15K RPM Seagate UltraSCSI drives
 2 x 2960 (AIC7892 rev 2) controllers
 2 x 3C59x 3Com ethernet controllers
 !USB card to free up IRQs (removed later)
 400W power supply
 240W power supply driving two of the hard drives + CD ROM
 Budget vid card
 2 drives partitioned 30%/70%, 30% mirrored together for boot, 70% mirrored
in RAID 0+1 with other drives

 I get EIP errors and Null pointer exception errors during full kernel
panics.  I've had a lot of file system corruption in ReiserFS originally and
now in EXT2, both fixable though Reiser seemed worse.  Uptime is measured in
hours - usually 12 or more, sometimes two or three.

I can't come up with any reasons for this that point at the kernel, but on
the other hand, nothing is ever logged regarding SCSI I/O problems (verbose
logging turned on in kernel with extra queue checks).  I've replaced the
> memory to no avail, and updated the BIOS' of both motherboard and Adaptec
cards.  No memory errors are logged and one pass of memtest86 found no
memory errors.

Yet, the machine crashes semi-randomly (load seems to play some part in
this) and often crashes during the shutdown/reboot phase if it's run
reliably for a few hours.

If it's hardware for sure, please just indicate that and I'll move on.  I'm
getting semi-desperate. :(

