Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270695AbTHAJJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 05:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270696AbTHAJJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 05:09:14 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:29089 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S270695AbTHAJJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 05:09:11 -0400
From: Rainer Keller <Keller@hlrs.de>
Organization: HLRS
To: linux-kernel@vger.kernel.org
Subject: Oops when running /sbin/modprobe -r parport_pc (2.6.0-test2)
Date: Fri, 1 Aug 2003 11:09:09 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011109.09138.Keller@hlrs.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
up to now, 2.6.0-test2 behaved very nicely! It's a real nice piece for a 
dot-zero version ,-]
But when doing /sbin/modprobe -r parport_pc, I got an OOPS with 
linux-2.6.0-test2.
Modprobe is from the latest module-init-tools-0.9.13-pre

Currently an lsmod is hanging in down, as well as an ksymoops:

4 0 32603 32602 25  0  1324  332 down   D    pts/1      0:00 /sbin/lsmod
4 0 32606 29233 15  0  1324  328 down   D    pts/1      0:00 lsmod

Here the OOPS:

Unable to handle kernel paging request at virtual address f88b85c4
 printing eip:
f88e543f
*pde = 01afb067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f88e543f>]    Tainted: PF
EFLAGS: 00010282
EIP is at cleanup_module+0xa/0x47 [parport_pc]
eax: f787fd80   ebx: f88e8300   ecx: 00000000   edx: f88e8300
esi: c02e0778   edi: 00000000   ebp: cc37a000   esp: cc37bf58
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 32316, threadinfo=cc37a000 task=deacf880)
Stack: cc37bf74 f88e8300 c02e0778 c012c169 f88e8300 0804e768 0000003b 
70726170
       5f74726f db006370 c618b980 caccd100 40017000 40018000 40018000 
caccd100
       db3b8380 db3b83a0 00000000 cc37a000 c0140a3b 003b8380 40017000 
0804e768
Call Trace:
 [<c012c169>] sys_delete_module+0x135/0x150
 [<c0140a3b>] sys_munmap+0x44/0x64
 [<c0108edb>] syscall_call+0x7/0xb

Code: 8b 15 c4 85 8b f8 85 d2 89 c3 74 23 85 db 74 0f f6 43 10 01


If You need the current .config, please let me know.

WIth best regards,
Rainer Keller
--
---------------------------------------------------------------
Dipl.-Inform. Rainer Keller    Keller@hlrs.de
Allmandring 30                 http://www.hlrs.de/people/keller
70550 Stuttgart                Tel.: 0711 / 685 5858

