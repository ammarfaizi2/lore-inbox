Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbRAWRla>; Tue, 23 Jan 2001 12:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRAWRlU>; Tue, 23 Jan 2001 12:41:20 -0500
Received: from cfa.harvard.edu ([131.142.10.1]:24527 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id <S129831AbRAWRlE>;
	Tue, 23 Jan 2001 12:41:04 -0500
Date: Tue, 23 Jan 2001 12:40:58 -0500 (EST)
From: John Roll <john@cfa.harvard.edu>
Message-Id: <200101231740.MAA27037@panic.harvard.edu>
To: linux-kernel@vger.kernel.org
Subject: Network hang with 2.4.1-pre9 and 3c59x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I read about some problems with my ethernet card (3c59x) but it was rumored
that they were fixed in 2.4.1-pre8.  I have 6 IDE drives raided together and
was stress testing the disk IO.  Suddenly there was no network!

[root@image log]# uname -a
Linux image.harvard.edu 2.4.1-pre9 #1 SMP Mon Jan 22 12:59:32 EST 2001 i686 unknown

>From the log:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e681.
  diagnostics: net 0cd8 media 8880 dma 0000003a.
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, full 0; dirty 18114(2) current 18114(2).
  Transmit list 00000000 vs. c14ab220.
  0: @c14ab200  length 8000002a status 8001002a
  1: @c14ab210  length 8000002a status 8001002a
  2: @c14ab220  length 800000fe status 000100fe
  3: @c14ab230  length 800005ea status 000105ea
  4: @c14ab240  length 800000fe status 000100fe
  5: @c14ab250  length 800000fe status 000100fe
  6: @c14ab260  length 800005ea status 000105ea
  7: @c14ab270  length 800000fe status 000100fe
  8: @c14ab280  length 800000fe status 000100fe
  9: @c14ab290  length 800000fe status 000100fe
  10: @c14ab2a0  length 800000fe status 000100fe
  11: @c14ab2b0  length 8000002a status 0001002a
  12: @c14ab2c0  length 8000002a status 0001002a
  13: @c14ab2d0  length 8000002a status 0001002a
  14: @c14ab2e0  length 8000002a status 0001002a
  15: @c14ab2f0  length 8000002a status 0001002a

... several more message blocks like this until I reboot ....

Here is the boot message showing my ethernet card:

3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe400,  00:01:02:c4:ae:cb, IRQ 16
  product code 'CG' rev 00.12 date 08-29-00
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
