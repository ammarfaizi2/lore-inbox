Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbSKCPzJ>; Sun, 3 Nov 2002 10:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbSKCPzJ>; Sun, 3 Nov 2002 10:55:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25357 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262080AbSKCPzH>;
	Sun, 3 Nov 2002 10:55:07 -0500
Date: Sun, 3 Nov 2002 16:01:39 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45: raid oops
Message-ID: <20021103160139.GA2653@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 16:00:12 up 41 min,  1 user,  load average: 0.01, 0.08, 0.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  With 2.5.45 (with the device mapper patches to get lvm to build on
2.5.45) when I start raid I get the following oops (its raid1 on ide
hda, hdg):

md: could not lock hda4.
md: could not import hda4!
Unable to handle kernel NULL pointer dereference at virtual address
00000004
 printing eip:
c028da27
*pde = 00000000
Oops: 0000

CPU:    0
EIP:    0060:[<c028da27>]    Not tainted
EFLAGS: 00010246
EIP is at export_rdev+0x7/0x90
eax: 0000001e   ebx: fffffff0   ecx: ffff8000   edx: 00000000
esi: 00000304   edi: 00000000   ebp: 00000304   esp: dccb3ee0
ds: 0068   es: 0068   ss: 0068
Process raidstart (pid: 264, threadinfo=dccb2000 task=dcc6b7c0)
Stack: fffffff0 c028f081 fffffff0 00000304 df757a04 00000000 dfcb8200
c028f8d7
       00000304 00000931 00000304 dfd17484 dfcb8400 df711e5c dccb3f1c
00000304
       00000000 00000000 0008f331 000061b0 00000001 00000000 00000006
00000304
Call Trace:
 [<c028f081>] autostart_array+0x101/0x110
 [<c028f8d7>] md_ioctl+0xe7/0x520
 [<c023f30a>] blkdev_ioctl+0x39a/0x3d0
 [<c0160b61>] sys_ioctl+0x271/0x2e8
 [<c0107617>] syscall_call+0x7/0xb

Code: 8b 43 14 85 c0 74 04 0f b7 50 10 52 e8 68 23 ef ff 83 c4 04

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
