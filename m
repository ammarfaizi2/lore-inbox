Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317649AbSGaCnv>; Tue, 30 Jul 2002 22:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317658AbSGaCnu>; Tue, 30 Jul 2002 22:43:50 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:45530 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S317649AbSGaCnu>; Tue, 30 Jul 2002 22:43:50 -0400
From: "David Luyer" <david@luyer.net>
To: <linux-kernel@vger.kernel.org>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Date: Wed, 31 Jul 2002 12:46:59 +1000
Message-ID: <013c01c2383c$8b2d4bf0$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Linux 2.4.19ac3rc3 on IBM x330/x340 SMP systems we're seeing this:

luyer@praxis8:~$ ps auxwww | tail -1
luyer     1025  0.0  0.0  1276  352 pts/2    S    Aug06   0:00 tail -1
luyer@praxis8:~$ date
Wed Jul 31 12:35:16 EST 2002

luyer@praxis8:~$ cat /proc/$$/stat
1053 (bash) S 1052 1053 1053 34818 1056 0 99 56 294 99 1 0 0 0 15 0 0 0
49574810 2244608 316 4294
967295 134512640 134997952 3221225056 3221224264 1074760249 0 65536
3686404 1266761467 3222376853
 0 0 17 0
luyer@praxis8:~$ cat /proc/uptime
495803.96 481602.41
luyer@praxis8:~$ cat /proc/stat
cpu  1570707 3 1853018 95737544
cpu0 685268 1 876356 48019011
cpu1 885439 2 976662 47718533
page 1720960 27277642
swap 25 534
intr 244887271 49580636 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1742620 0 16 16 193563981 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (8,0):(988585,67688,1019318,920897,8472052)
(8,1):(1832129,206174,2422602,1625955,460832
32)
ctxt 81010049
btime 1027587797
processes 98440

Note the time skew in the "ps" output (the clock time is correct).

This is happening on all ten IBM x330/x340's we're running this in SMP
on this kernel.

We have fourteen Intel ISP 2150 servers running UP with IO-APIC on SMP
motherboards which are not experiencing this issue.

David.
--
David Luyer                                     Phone:   +61 3 9674 7525
Network Development Manager    P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 BYTE
http://www.pacific.net.au/                      NASDAQ:  PCNTF

