Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261479AbTCTOM0>; Thu, 20 Mar 2003 09:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbTCTOM0>; Thu, 20 Mar 2003 09:12:26 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:17938 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id <S261479AbTCTOMZ>; Thu, 20 Mar 2003 09:12:25 -0500
Subject: kswapd oops in 2.4.20 SMP+NFS
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048170204.5161.11.camel@calculon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Mar 2003 15:23:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I got the following oops recently. The machine is still up and running
and was working stably for a year now...

Linux 2.4.20 #1 SMP Tue Dec 10 11:16:20 CET 2002 i686 unknown
2 x AMD K7-MP 1200MHz PCI(5-64)	TYAN Thunder K7 S2462 Mainboard 1G ECC Memory

[...]
nfsd-fh: found a name that I didn't expect: sys/oz
nfsd-fh: found a name that I didn't expect: sys/oz
nfsd-fh: found a name that I didn't expect: bin/x86
nfsd-fh: found a name that I didn't expect: bin/x86
nfsd-fh: found a name that I didn't expect: etc/bla
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Unable to handle kernel paging request at virtual address 00268eb7
 printing eip:
c014f5a3
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c014f5a3>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: e34b05c0   ecx: e34b05d0   edx: d1da1c40
esi: d6c03e00   edi: 00268ea7   ebp: 0000318e   esp: f7edff34
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=f7edf000)
Stack: d1da1c58 e34b05c0 e34b05c0 c017a75f e34b05c0 d1da1c58 d1da1c40 c014cf20 
       d1da1c40 e34b05c0 00000006 000001d0 00000020 00000006 c014d2ab 000108c9 
       c0132046 00000006 000001d0 00000006 00000020 000001d0 c02d94b4 c02d94b4 
Call Trace:    [<c017a75f>] [<c014cf20>] [<c014d2ab>] [<c0132046>] [<c013209c>]
  [<c01321a1>] [<c0132206>] [<c013232d>] [<c0105708>]

Code: 8b 47 10 85 c0 74 06 53 ff d0 83 c4 04 68 f0 a3 2d c0 8d 43 


