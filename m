Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTARMxw>; Sat, 18 Jan 2003 07:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbTARMxw>; Sat, 18 Jan 2003 07:53:52 -0500
Received: from kunde0416.oslo-asen.alfanett.no ([62.249.189.163]:27667 "EHLO
	kunde0416.oslo-asen.alfanett.no") by vger.kernel.org with ESMTP
	id <S264697AbTARMxv>; Sat, 18 Jan 2003 07:53:51 -0500
Date: Sat, 18 Jan 2003 14:02:40 +0100 (CET)
From: Peter Karlsson <peter@softwolves.pp.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 kernel crashes while scanning partition list
Message-ID: <Pine.LNX.4.43.0301181344200.32727-100000@perkele>
Mail-Copies-To: Peter Karlsson <peter@softwolves.pp.se>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am installing Debian Linux on my new Athlon XP PC, and I have
problems with the 2.4.20 kernel crashing on boot. I can successfully
boot using the 2.4.18 kernel build that is included with the Debian 3.0
install cds.

The problems seems to stem from my use of Promise FastTrak133 RAID
controller (yes, I know they say it sucks, but it's what is integrated
on the MB). In 2.4.18, I can get ataraid working, although I have to
specify the address to the IDE controller manually. 2.4.20 picks that
up automatically, but crashes when enumerating the HD partitions
(reproducible every time).

The crash output looks like this (I had to write it down by hand, hopefully
there will be no typos):

{{{output from enumerating partitions on /dev/ataraid/d0}}}
Unable to handle kernel NULL pointer dereference at virtual address 0000000
printing eip: 00000000
*pde = 00000000
Oops: 00000000
CPU: 0
EIP: 0010:[<00000000>] Not tainted
EFLAGS: 00010282
eax: 00000000 ebx: 00000000 ecx: c038c740 edx: 00000000
esi: f7e80f40 edi: 0040f5c8 ebp: 06ed3cf9 esp: c1c17d94
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, stackpage=c1c17000)
Stack: c01e5ddc c038c740 00000000 f7e80f40 00000002 00000000 f7e80dc0 c1a7b3d0
       c01e5e3e 00000000 f7e80f40 00000000 00000006 c01351b0 00000000 f7e80f40
       c1a7b3d0 d7fbcdb4 00000000 f7ed0d30 00001000 00000004 00000400 f7e80f40
Call trace: [<c01e5ddc>] [<c01e5e3e>] [<c01351b0>] [<c012580c>] [<c0137d6f>]
            [<c0137cd0>] [<c0127c75>] [<c0152162>] [<c0137d60>] [<c01522a3>]
            [<c0116315>] [<c015278b>] [<c014538e>] [<c013811d>] [<c0151f84>]
            [<c01345f8>] [<c0296373>] [<c02093a8>] [<c02094ac>] [<c0209437>]
            [<c01520f7>] [<c0152036>] [<c0208af4>] [<c0105037>] [<c01055b8>]
Code: Bad EIP value.
<0>Kernel panic: Attempted to kill init!

The corresponding System.map file can be downloaded at
<URL:http://www.softwolves.pp.se/tmp/2.4.20/System.map-2.4.20> and a
partition list from sfdisk -l can be found at
<URL:http://www.softwolves.pp.se/tmp/2.4.20/partlist.txt>.

The motherboard is a MSI KT3Ultra2 ("VIA KT333 chipset based"), the CPU
is an Athlon XP2200+, and the machine has 1 Gbyte of RAM.

Any help in getting this resolved would be greatly appreciated! I
really would like to move on from my old K6 machine...

Please Cc replies to me, I do not subscribe to the list due to its
volume.
-- 
\\//
Peter - http://www.softwolves.pp.se/

  I do not read or respond to mail with HTML attachments.

