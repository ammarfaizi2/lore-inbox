Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290715AbSBFRyO>; Wed, 6 Feb 2002 12:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290718AbSBFRyE>; Wed, 6 Feb 2002 12:54:04 -0500
Received: from Expansa.sns.it ([192.167.206.189]:60178 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S290715AbSBFRxz>;
	Wed, 6 Feb 2002 12:53:55 -0500
Date: Wed, 6 Feb 2002 18:53:47 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: reiserfs-dev@namesys.com, <reiser@namesys.com>,
        <linux-kernel@vger.kernel.org>
Subject: oops with reiserfs and kernel 2.5.4-pre1 on sparc64
Message-ID: <Pine.LNX.4.44.0202061850060.17669-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I was trying 2.5.4-pre1 on sparc64 sun4u ultra2,
with 1GB memory and scsi controller ess.
This system has just one CPU.

I get this oops while trying to mount the /usr filesystem: which is on
reiserFS:

mount(40): Kernel bad sw trap 5
TSTATE: 0000000011009607 TPC: 000000000046cf7c TNPC: 000000000046cf80 Y: 07000000    Not tainted
g0: fffff8006ff057a0 g1: 000000000003775d g2: 0000000000000018 g3: 0000000000000001
g4: fffff80000000000 g5: 0000000000000001 g6: fffff8006f074000 g7: 0000000000000001
o0: 000000000ffffe00 o1: 0000000000001e00 o2: ffffffffffffffff o3: 0000000000001fff
o4: 0000000000040a00 o5: fffff8006fe09908 sp: fffff8006f076d81 ret_pc: 000000000046cf38
l0: 0000000000009908 l1: fffff8006f79e2a0 l2: 00000000005c44d8 l3: 00000000005c4908
l4: 00000000005cc800 l5: fffff8006ef05e60 l6: 000000007002aa38 l7: 0000000070029ef0
i0: fffff8006f79e2a0 i1: 0000000000002012 i2: 0000000010000000 i3: 0000000000000000
i4: fffff8006f808f78 i5: 00000001fffda000 i6: fffff8006f076e81 i7: 000000000046b260
Caller[000000000046b260]
Caller[000000000046b56c]
Caller[00000000004d1374]
Caller[00000000004b3540]
Caller[000000000046f124]
Caller[000000000046f3cc]
Caller[00000000004828cc]
Caller[0000000000482c08]
Caller[000000000042fa28]
Caller[0000000000410974]
Caller[000000000001274c]
Instruction DUMP: 9006be00  92126200  80a20009 <99d02005> 9002a001
953a2000  932e800a  80a2400b  084ffffd
Error (Oops_bfd_perror): scan_arch for specified architecture Success

>>TPC; 0046cf7c <grow_buffers+5c/e0>   <=====
>>O7;  0046cf38 <grow_buffers+18/e0>
>>I7;  0046b260 <__getblk+20/60>
Trace; 0046b260 <__getblk+20/60>
Trace; 0046b56c <__bread+c/a0>
Trace; 004d1374 <journal_init+214/8e0>
Trace; 004b3540 <reiserfs_read_super+140/600>
Trace; 0046f124 <get_sb_bdev+224/2c0>
Trace; 0046f3cc <do_kern_mount+4c/160>
Trace; 004828cc <do_add_mount+6c/1a0>
Trace; 00482c08 <do_mount+168/1a0>
Trace; 0042fa28 <sys32_mount+108/160>
Trace; 00410974 <linux_sparc_syscall32+34/40>
Trace; 0001274c Before first symbol

I am willing to test any patch.
I hope this helps

Luigi Genoni


