Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbVBER31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbVBER31 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbVBER30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 12:29:26 -0500
Received: from rost.dti.supsi.ch ([193.5.152.238]:19850 "EHLO
	rost.dti.supsi.ch") by vger.kernel.org with ESMTP id S265290AbVBER3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 12:29:19 -0500
Date: Sat, 5 Feb 2005 18:29:17 +0100 (CET)
From: Marco Rogantini <marco.rogantini@supsi.ch>
X-X-Sender: rogantin@rost.dti.supsi.ch
To: linux-kernel@vger.kernel.org
Subject: rtl8139 (8139too) net problem in linux 2.6.10
Message-ID: <Pine.LNX.4.62.0502051818370.4821@rost.dti.supsi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a problem with my RTL-8139C based CardBus network interface.
I'm using the 8139too driver of linux-2.6.10.

When outgoing traffic becomes high it is interrupted for several
seconds and i get this:

sort kernel: NETDEV WATCHDOG: eth1: transmit timed out
sort kernel: eth1: Transmit timeout, status 0d 0000 c07f media 00.
sort kernel: eth1: Tx queue start entry 8588  dirty entry 8584.
sort kernel: eth1:  Tx descriptor 0 is 00120386. (queue head)
sort kernel: eth1:  Tx descriptor 1 is 0012003c.
sort kernel: eth1:  Tx descriptor 2 is 00120056.
sort kernel: eth1:  Tx descriptor 3 is 0012003c.
sort kernel: eth1: link up, 100Mbps, full-duplex, lpa 0x41E1

after some seconds the network traffic resumes but almost
immediately after I get an other 'transmit timed out' and so on...

Output of 'rtl8139-diag -af' is
rtl8139-diag.c:v2.11 4/22/2003 Donald Becker (becker@scyld.com)
  http://www.scyld.com/diag/index.html
Index #1: Found a RealTek RTL8139 adapter at 0x4000.
RealTek chip registers at 0x4000
  0x000: 354f3000 00007fda 80000000 40800000 0008a062 0008a03c 0008a03c 
0008a062
  0x020: 1f3dc000 1f3dc600 1f3dcc00 1f3dd200 1ec70000 0d0a0000 00640054 
0000c07f
  0x040: 74000680 0000f7ce 33c2d3de 00000000 000d1000 00000000 0089cd00 
00100000
  0x060: 1100f00f 01e1782d 000141e1 00000000 00000004 000417c8 b0f243b9 
8a36df43.
Realtek station address 00:30:4f:35:da:7f, chip type 'rtl8139C'.
   Receiver configuration: Normal unicast and hashed multicast
      Rx FIFO threshold 2048 bytes, maximum burst 2048 bytes, 32KB ring
   Transmitter enabled with NONSTANDARD! settings, maximum burst 1024 
bytes.
     Tx entry #0 status 0008a062 complete, 98 bytes.
     Tx entry #1 status 0008a03c complete, 60 bytes.
     Tx entry #2 status 0008a03c complete, 60 bytes.
     Tx entry #3 status 0008a062 complete, 98 bytes.
   Flow control: Tx disabled  Rx disabled.
   The chip configuration is 0x10 0x0d, MII half-duplex mode.
   No interrupt sources are pending.


Can anybody please help me ?

Many thanks,

         -marco

