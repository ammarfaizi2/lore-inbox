Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314043AbSDVDb1>; Sun, 21 Apr 2002 23:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314048AbSDVDb0>; Sun, 21 Apr 2002 23:31:26 -0400
Received: from 137-5.red-dsl.cpl.net ([192.216.137.5]:55045 "HELO
	mail.heronforge.net") by vger.kernel.org with SMTP
	id <S314043AbSDVDb0>; Sun, 21 Apr 2002 23:31:26 -0400
Date: Sun, 21 Apr 2002 20:31:24 -0700 (PDT)
From: Stephen Carville <carville@cpl.net>
X-X-Sender: <stephen@warlock.heronforge.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Kernel oops and drive failure
Message-ID: <Pine.LNX.4.33.0204212029200.2467-100000@warlock.heronforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded to 2.4.18 on a dual processor Dell 2550 server.
This is a backup Oracle servers (9i).  Last night the load average
jumped to about 4 and an hour later to about 7.  Top reports the CPU
utilization is less than 5%.  Nevertheless the load averages keep
climbing.


About the time the load average jumped the log reports:

----------------------

Apr 21 18:09:54 jordan kernel: Device 08:41 not ready.

Apr 21 18:09:54 jordan kernel:  I/O error: dev 08:41, sector 98566248

Apr 21 18:09:54 jordan kernel: raid5: Disk failure on sde1, disabling
device. Operation continuing on 3 devices

Apr 21 18:09:54 jordan kernel: md: recovery thread got woken up ...

Apr 21 18:09:54 jordan kernel: Unable to handle ke<1lUaULLblepto
tandde kfeeencernel NULL pointer dereference<6>md: recovery thread
finished ...

Apr 21 18:09:54 jordan kernel: md: recovery thre00000f80

Apr 21 18:09:54 jordan kernel:  printing eip:

Apr 21 18:09:54 jordan kernel: c01c067e

Apr 21 18:09:54 jordan kernel: *pde = 00000000

Apr 21 18:09:54 jordan kernel: Oops: 0002

Apr 21 18:09:54 jordan kernel: CPU:    0

Apr 21 18:09:54 jordan kernel: EIP:    0010:[<c01c067e>]    Not
tainted

Apr 21 18:09:54 jordan kernel: EFLAGS: 00010202

Apr 21 18:09:54 jordan kernel: eax: 00000841   ebx: f77db180   ecx:
00000020   edx: 00000841

Apr 21 18:09:54 jordan kernel: esi: f77db380   edi: 00000f80   ebp:
c201f660   esp: f77d9f48

Apr 21 18:09:54 jordan kernel: ds: 0018   es: 0018   ss: 0018

Apr 21 18:09:54 jordan kernel: Process raid5d (pid: 20,
stackpage=f77d9000)

Apr 21 18:09:54 jordan kernel: Stack: 00000000 f77df000 f77dc000
f7ead280 c201f6a0 c01c0729 f7ead280 c201f660

Apr 21 18:09:54 jordan kernel:        00000001 f78d3c00 f7ead280
00000000 c01c07ff f7ead280 00000064 00000001

Apr 21 18:09:54 jordan kernel:        f78d3c00 f77d8000 00000000
f8845b3b f7ead280 fffffc18 00000000 c0274000

Apr 21 18:09:54 jordan kernel: Call Trace: [<c01c0729>] [<c01c07ff>]
[<f8845b3b>] [<f8845b20>] [<c01c360a>] Apr 21 18:09:54 jordan kernel:
[<c0105876>] [<c01c34c0>]

Apr 21 18:09:54 jordan kernel:

Apr 21 18:09:54 jordan kernel: Code: f3 a5 8b 83 00 02 00 00 89 45 3c
c7 04 24 01 00 00 00 8b 1c

-------------------------

I guess this a kernel 'oops'?

Please CC me on any response.  I am not a member of this list.

-- 
-- Stephen Carville http://www.heronforge.net/~stephen/gnupgkey.txt
==============================================================
Government is like burning witches:  After years of burning young
women failed to solve any of society's problems, the solution was to
burn more young women.
==============================================================

