Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277115AbRJDE13>; Thu, 4 Oct 2001 00:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277117AbRJDE1V>; Thu, 4 Oct 2001 00:27:21 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:18336 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S277115AbRJDE1M>; Thu, 4 Oct 2001 00:27:12 -0400
Date: Wed, 3 Oct 2001 21:29:41 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: no counters in /proc/net/dev with the ns83820 driver?
Message-ID: <Pine.LNX.4.33.0110032111510.1941-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this strike me as a bit odd.

with the driver version 1.34 (kernel is 2.4.9ac7) no statistics are
collected in /proc/net/dev, output follows

[joelja@route-views-test net]$ cat dev
Inter-|   Receive                                                |
Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes
packets errs drop fifo colls carrier compressed
    lo:    1514      18    0    0    0     0          0         0     1514
18    0    0    0     0       0          0
  eth0: No statistics available

driver is built as a module:

ns83820.c: National Semiconductor DP83820 10/100/100 driver.
eth%d: disabling 64 bit PCI.
eth0: ns83820.c v0.10: DP83820 00:50:ba:37:d9:a6 pciaddr=0xf9020000 irq=12
rev 0x102
eth0: link now 10 mbps, half duplex and up.

the card in question is the dlink dfe-500t

it is connected directly to a 10Mb/s interface on an older cisco 7200
router for what it's worth. it interface is recieving about 650 packets
per second accarding to tcpdump.

the system is built around a via apollo pro266 vt8633 chipset mainboard
(supermicro p3tdde) with dual 1ghz cpus and an smp kernel.

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


