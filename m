Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319243AbSHNQeR>; Wed, 14 Aug 2002 12:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319248AbSHNQeR>; Wed, 14 Aug 2002 12:34:17 -0400
Received: from mail.arcor.net ([145.253.32.2]:38876 "EHLO mail.arcor.net")
	by vger.kernel.org with ESMTP id <S319243AbSHNQeQ>;
	Wed, 14 Aug 2002 12:34:16 -0400
X-Lotus-FromDomain: ARCOR
From: Holger.Woehle@arcor.net
To: linux-kernel@vger.kernel.org
Message-ID: <41256C15.00613A82.00@ffm-hq-gtw01.Arcor.net>
Date: Wed, 14 Aug 2002 18:37:31 +0100
Subject: sundance.o only two ports working
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i have a strange problem with two of my machines:
They are identical P4 systems with Intel Chipset with two epro100 adapters
onboard and a d-link dfe-580TX quad ethernet card.
I am using Kernel 2.4.18 and sundance.o v1.07a 7/9/2002.
The problem is, that i only can use the two first ports of the d-link card.
I can set up all four with no problems according to mii-diag and alta-diag.
Each port recognises link up/down and negotiates to the right speed and
flowcontrol.
But when i send traffic over the ports 4&5, at first nothing happens and of
course i can't see any interrupts in /proc/interrupts eth4 eth5 and after a
while i get
the console message:
eth4: Transmit timed out, status c0, resetting...

Having a look at alta-diag i noticed, that the column
" Interrupt status is..." differs between Index#1 / #2 and Index#3 / #4
Index#1 and #2 tells: Interrupt status is 0000: No interrupts pending.
Index#3 and #4 tells: Interrupt status is 0101: Interrupt summary Link status
changed

and after genrating some traffic that line changes at Index#3 & #4 to:

Interrupt status is 0301: Interrupt summary Link status changed Tx DMA done.

The beehavier is identical on both machines.

For better analysing i can send a file including cat /proc/pic, pci-config,
alta-diag -e and alta-diag -m bevor and after sending some pings.
This file is a some more pages long so i don't know if it is ok to send it to
the mailing list.

with regards
Holger



