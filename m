Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277230AbRJQV03>; Wed, 17 Oct 2001 17:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277237AbRJQV0U>; Wed, 17 Oct 2001 17:26:20 -0400
Received: from [24.3.101.71] ([24.3.101.71]:56816 "EHLO SpaceServices.net")
	by vger.kernel.org with ESMTP id <S277231AbRJQV0M>;
	Wed, 17 Oct 2001 17:26:12 -0400
Message-Id: <200110172125.f9HLPrBK029404@SpaceServices.net>
Content-Type: text/plain; charset=US-ASCII
From: Brandon Penglase <linux-kernel@SpaceServices.net>
Organization: Space Networks
To: linux-kernel@vger.kernel.org
Subject: 2.4.12 & greater problem.
Date: Wed, 17 Oct 2001 17:26:41 -0400
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   I have tried this with the 2.4.12 bare kernel, and 2.4.12 with the
pre-emptive patch. Both do the same. Now, 2.4.13-pre2 bare and 2.4.13-pre2 w/
pre-emptive patch does the same. When I boot my laptop (IBM Thinkpad 600 w/
toshiba 10gig HDD, ReiserFS partitions and 1 win2k partition) I normall get a
stuff about FAT: errors, then it mounts and check the journal, and it all
works. Now, I get this error (excuse missing parts, as its kinda long, and I
had to write it since it never made it in the log..)

Fat: bogus Logical Sector Size 0
umsdos: msdos_read_super failed, mount aborted.
Fat: Bogus Logibal Sector Size 0
** normall right here is where it would check the Reiser Log and so on **
invaild operand: 0000
CPU: 0
EIP: 0010: [<c01c66fd>] Not Tained
EFlags: 00010246
eax: 00000001 ebx: 00000000 ecx: 00002000 edx: 00000000
esi: c6f12ae0 edi: 0000001 ebp: c03a42c0 esp: c11d9e54
ds: 0018 es: 0018 ss: 0012
Process Swapper cpid: 1, stack *something* = c11d90001
Stack: 00000304 c6f169e0 00000000 005b5cc0 00000000
CallTime: [<c017589a7>] [<c01758bc>]
code: 0f 0b 0f b6 46 15 0f b7 4e 14 8b 14 85
c0 cd 39 c0 85 d2 75
    (0) Kernel Panic: attempted to kill init!


Sorry if this is missing stuff, or stuff is wrong, but I have VERY bad hand
writing, and I had to write this out on a sheet of paper.  I'm assuming this
is with ReiserFS since its not checking the journal, and is failing where it
normally would. To help out a little.. here is the spot on the 2.4.10 kernel
(bare, which I'm running now) at this spot when it boots:

Oct 15 15:08:49 Sattelite kernel: IPv6 v0.8 for NET4.0
Oct 15 15:08:49 Sattelite kernel: IPv6 over IPv4 tunneling driver
Oct 15 15:08:49 Sattelite kernel: UMSDOS: msdos_read_super failed, mount
aborted.
Oct 15 15:08:49 Sattelite kernel: Adding Swap: 257032k swap-space (priority
-1)
Oct 15 15:08:49 Sattelite kernel: Linux PCMCIA Card Services 3.1.29
Oct 15 15:08:49 Sattelite kernel:   kernel build: 2.4.10 #1 Mon Sep 24
18:31:14 EDT 2001
Oct 15 15:08:49 Sattelite kernel:   options:  [pci] [cardbus] [apm]
Oct 15 15:08:49 Sattelite kernel: Intel ISA/PCI/CardBus PCIC probe:

Of course, in the spot in here, that isn't reported in the log, is it
checking the journal log and so on.

Any help would be great!

     Brandon Penglase
