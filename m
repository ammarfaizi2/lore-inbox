Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129751AbRAaXXM>; Wed, 31 Jan 2001 18:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129832AbRAaXXC>; Wed, 31 Jan 2001 18:23:02 -0500
Received: from cr753963-a.glph1.on.wave.home.com ([24.112.144.48]:60807 "EHLO
	cr753963-a.glph1.on.wave.home.com") by vger.kernel.org with ESMTP
	id <S129828AbRAaXWx>; Wed, 31 Jan 2001 18:22:53 -0500
Date: Wed, 31 Jan 2001 18:30:18 -0500 (EST)
From: <linux@cr753963-a.glph1.on.wave.home.com>
To: linux-kernel@vger.kernel.org
Subject: Networking problems with 2.4.0 and 2.4.1
Message-ID: <Pine.LNX.4.21.0101311823580.7800-100000@cr753963-a.glph1.on.wave.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since using kernel 2.4.0 and 2.4.1 I have been having very weird problems
with my network.  Suddenly the network connection drops and dies until I
take down the interface, and then successfully ping a machine. This is the
only thing that I can get out of syslog that is relevant:

Jan 31 14:17:29 cr753963-a kernel: eth1: 21143 10baseT link beat good.
Jan 31 14:17:50 cr753963-a kernel: NETDEV WATCHDOG: eth1: transmit timed 
out
Jan 31 14:17:50 cr753963-a kernel: eth1: 21041 transmit timed out, status
fc6908c5, CSR12 000001c8, CSR13 ffffef05, CSR14 ffffff3f, resetting...
Jan 31 14:17:50 cr753963-a kernel: eth1: 21143 100baseTx sensed media.

The only problem is, is that eth1 is a 10mbit card. This also happens when
I remove eth1, and only have eth0 in the computer. I put eth1 to see if it
would fix the problem.

Relevant info:

Jan 30 21:26:37 cr753963-a kernel: eth1: Digital DC21041 Tulip rev 33 at
0xe400, 21041 mode, 00:E0:29:11:0F:3A, IRQ 10.
Jan 30 21:26:37 cr753963-a kernel: eth1: 21041 Media table, default media
0000 (10baseT).
Jan 30 21:26:37 cr753963-a kernel: eth1:  21041 media #0, 10baseT.
Jan 30 21:26:37 cr753963-a kernel: eth1:  21041 media #4, 10baseT-FD.

Jan 30 21:26:37 cr753963-a kernel: ne.c: ISAPnP reports Generic PNP at i/o
0x220, irq 5.
Jan 30 21:26:37 cr753963-a kernel: ne.c:v1.10 9/23/94 Donald Becker
(becker@scyld.com)
Jan 30 21:26:37 cr753963-a kernel: Last modified Nov 1, 2000 by Paul
Gortmaker
Jan 30 21:26:37 cr753963-a kernel: NE*000 ethercard probe at 0x220: 00 40
f6 24 34 08
Jan 30 21:26:37 cr753963-a kernel: eth0: NE2000 found at 0x220, using IRQ
5.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
