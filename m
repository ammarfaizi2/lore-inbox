Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRDBVH7>; Mon, 2 Apr 2001 17:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131320AbRDBVHt>; Mon, 2 Apr 2001 17:07:49 -0400
Received: from tahallah.claranet.co.uk ([212.126.138.206]:33290 "EHLO
	tahallah.clara.co.uk") by vger.kernel.org with ESMTP
	id <S131248AbRDBVHk>; Mon, 2 Apr 2001 17:07:40 -0400
Date: Mon, 2 Apr 2001 22:06:53 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.clara.co.uk>
X-X-Sender: <alex@tahallah.clara.co.uk>
Reply-To: <alex.buell@tahallah.clara.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Swapping wierdness on SparcStation 4 w/ 2.2.19
Message-ID: <Pine.LNX.4.33.0104022201460.4049-100000@tahallah.clara.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built and installed 2.2.19 on my SparcStation 4 last night, and have
been testing it by recompiling gcc 2.95.2 over and over. Just noticed now
that it doesn't seem to swap at all, despite the fact that the swap
partition exists and is active.

Here's the output from procinfo (snipped for brevity)

Linux 2.2.19 (root@sparc4) (gcc 2.95.2 19991024 ) #6 Sun Apr 1 22:23:42 BST 2001 1CPU [sparc4.]

Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:         95532       89512        6020       23784       29560       37576
Swap:       131120           0      131120

Bootup: Sun Apr  1 23:45:56 2001    Load average: 1.00 1.00 1.00 3/40 19021

Here's the output from swapon -s:

[alex@sparc4]/home/alex > swapon -s
Filename                        Type            Size    Used    Priority
/dev/sda2                       partition       131120  0       -1

Here's the /proc/cpuinfo, in case it is relevant

[alex@sparc4]/home/alex > cat /proc/cpuinfo
cpu             : Fujitsu  MB86904
fpu             : Lsi Logic/Meiko L64804 or compatible
promlib         : Version 3 Revision 2
prom            : 2.24
type            : sun4m
ncpus probed    : 1
ncpus active    : 1
BogoMips        : 109.77
MMU type        : Fujitsu Swift
invall          : 0
invmm           : 0
invrnge         : 0
invpg           : 0
contexts        : 256

I'm not currently subscribed to the l-k mailing list so feel free to cc me
on any replies, thanks.

-- 
I'm just too silly for you.

http://www.tahallah.clara.co.uk

