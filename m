Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269992AbRHETBS>; Sun, 5 Aug 2001 15:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270000AbRHETBJ>; Sun, 5 Aug 2001 15:01:09 -0400
Received: from k213a.lanhovi.ton.tut.fi ([193.166.80.217]:12681 "HELO
	butthead.ton.tut.fi") by vger.kernel.org with SMTP
	id <S269992AbRHETAt>; Sun, 5 Aug 2001 15:00:49 -0400
Date: Sun, 5 Aug 2001 22:00:57 +0300
To: linux-kernel@vger.kernel.org
Subject: mount bug
Message-ID: <20010805220057.A16219@k213a.lanhovi.ton.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: samppa@k213a.lanhovi.ton.tut.fi (Sami Nieminen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting a random kernel bug upon mounting my SCSI dvd drive. It's
random because it doesn't happend every time when I mount. I copied some CDs
to SCSI hd during the past few days and had to mount/umount several times. 
Mount hung twice and I got the following message on my syslog:

------------------------------------------------------------------------
Aug  5 21:10:02 beavis kernel: Unable to handle kernel paging request at
virtual address e2da6998
Aug  5 21:10:02 beavis kernel:  printing eip:
Aug  5 21:10:02 beavis kernel: e2da6998
Aug  5 21:10:02 beavis kernel: *pde = 1e523067
Aug  5 21:10:02 beavis kernel: *pte = 00000000
Aug  5 21:10:02 beavis kernel: Oops: 0000
Aug  5 21:10:02 beavis kernel: CPU:    0
Aug  5 21:10:02 beavis kernel: EIP:
0010:[af_packet:__insmod_af_packet_O/lib/modules/2.4.7-6mdksmp/kernel/net/p+-22120/96]
Aug  5 21:10:02 beavis kernel: EIP:    0010:[<e2da6998>]
Aug  5 21:10:02 beavis kernel: EFLAGS: 00010296
Aug  5 21:10:02 beavis kernel: eax: 00000000   ebx: d9901ba0   ecx:
00000286edx: 00000000
Aug  5 21:10:02 beavis kernel: esi: 00000000   edi: df011d80   ebp:
00000000esp: df011d34
Aug  5 21:10:02 beavis kernel: ds: 0018   es: 0018   ss: 0018
Aug  5 21:10:02 beavis kernel: Process mount (pid: 5460, stackpage=df011000)
Aug  5 21:10:02 beavis kernel: Stack: 000000c8 00000000 c67fb414 e2da8760
00000000 e2da8760 00000000 00000001
Aug  5 21:10:02 beavis kernel:        00000000 d9901bf4 c19d2e00 e2da6abf
00000000 df011d80 00000000 00000000
Aug  5 21:10:02 beavis kernel:        00000001 00000003 00000000 00000000
00000000 0000001b e2da6bb2 00000000
Aug  5 21:10:02 beavis kernel: Call Trace: [open_for_data+239/708]
[cdrom_open+130/188] [blkdev_get+229/296] [get_sb_bdev+351/512]
[do_add_mount+258/572]
Aug  5 21:10:02 beavis kernel: Call Trace: [<c01a802f>] [<c01a7f06>]
[<c013ef25>] [<c013cac3>] [<c013d44a>]
Aug  5 21:10:02 beavis kernel:
[af_packet:__insmod_af_packet_O/lib/modules/2.4.7-6mdksmp/kernel/net/p+-34744/96]
[af_packet:__insmod_af_packet_O/lib/modules/2.4.7-6mdksmp/kernel/net/p+-34744/96]
[do_mount+242/268] [copy_mount_options+84/160] [sys_mount+175/284]
[system_call+51/64]
Aug  5 21:10:02 beavis kernel:    [<e2da3848>] [<e2da3848>] [<c013d716>]
[<c013d5d8>] [<c013d7df>] [<c0106fa3>]
Aug  5 21:10:02 beavis kernel:
Aug  5 21:10:02 beavis kernel: Code:  Bad EIP value.
------------------------------------------------------------------------

This is SMP box (2xP3-850) with Abit VP6 motherboard (VIA), Tekram DC390 U2W 
SCSI controller and 512MB of RAM. It is running Mandrake kernel 2.4.7-6mdksmp, 
which is essentially a 2.4.7-ac5.

P.S. CC to me as I am not subscribed to lkml.

--
Sami Nieminen
