Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262263AbSJAUiZ>; Tue, 1 Oct 2002 16:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262270AbSJAUiZ>; Tue, 1 Oct 2002 16:38:25 -0400
Received: from p508EF4E0.dip.t-dialin.net ([80.142.244.224]:38600 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id <S262263AbSJAUhx>;
	Tue, 1 Oct 2002 16:37:53 -0400
Date: Tue, 1 Oct 2002 22:43:18 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops on boot with 2.5.40 bk
Message-ID: <20021001204318.GA17826@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everyone,

I got the following oops while md auto-detection during boot.
Kernel is 2.5.40-bk, because kernel.org is down for me.

There once was a raid-array configured, but I cleared all
partitions using dd ...

Here's the oops, thanks for listening:

Adding 144576k swap on /dev/sda1.  Priority:0 extents:1
Adding 144576k swap on /dev/sdb1.  Priority:0 extents:1
Adding 144576k swap on /dev/sdc1.  Priority:0 extents:1
Adding 144576k swap on /dev/sdd1.  Priority:0 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,2), internal journal
 [events: 00000000]
md: invalid raid superblock magic on sda4
md: sda4 has invalid sb, not importing!
md: could not import sda4!
general protection fault: 0000
 
CPU:    0
EIP:    0060:[<c02628fb>]    Not tainted
EFLAGS: 00010246
EIP is at export_rdev+0x7/0x84
eax: 0000001e   ebx: ffffffea   ecx: c036ae88   edx: 00000000
esi: 00000804   edi: ffffffea   ebp: 00000804   esp: df9bdee8
ds: 0068   es: 0068   ss: 0068
Process raidstart (pid: 64, threadinfo=df9bc000 task=dfcf7500)
Stack: ffffffea c0264510 ffffffea 00000804 00000804 00000804 00000000 c0264e39 
       00000804 00000931 dfc7d580 00000804 df99c400 00000802 00000000 dfc7fe00 
       00000804 000061b0 00000001 00000000 00000006 00000804 00000000 00000000 
Call Trace:
 [<c0264510>]autostart_array+0x12c/0x138
 [<c0264e39>]md_ioctl+0xed/0x588
 [<c013cb26>]blkdev_ioctl+0xba/0xf4
 [<c0143bc7>]sys_ioctl+0x21b/0x234
 [<c0108743>]syscall_call+0x7/0xb

Code: 8b 43 14 85 c0 74 04 0f b7 50 10 52 e8 48 59 ef ff 83 c4 04 
