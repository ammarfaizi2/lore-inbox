Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSGAKZ0>; Mon, 1 Jul 2002 06:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSGAKZZ>; Mon, 1 Jul 2002 06:25:25 -0400
Received: from mail.eunet.ch ([146.228.10.7]:44303 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S314680AbSGAKZZ>;
	Mon, 1 Jul 2002 06:25:25 -0400
Subject: hopefully solved (was: 2.4.17 freezes)
From: Robin Farine <robin.farine@acn-group.ch>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Jul 2002 12:23:07 +0200
Message-Id: <1025518987.5498.69.camel@halftrack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On February, I reported some problems with my office PCs running 2.4.17.
I tried 2.4.18 with the PC on my desk and observed the same problem.
But, comparing interrupts mapping with the machines running 2.2.20, I
noticed that my machine (2.4.18) mapped the Ethernet NICs interrupts to
interrupt 9, a high priority vector also shared by ACPI and USB, instead
of 10 like the other PCs (2.2.20).

>From the BIOS setup, I forced the PCI slot with the NIC to use interrupt
7 (low priority) and since then my machine runs without problem.

Since these 3 PCs have DEC chips based NICs, I suspect a possible
problem with the tulip driver, something like a status bit not cleared
before re-enabling the chip's interrupt, which only results into a
catastrophic situation when the associated interrupt vector has a very
high priority (4)? However, these are just speculations and I don't have
the knowledge required to quickly verify them.

Robin

P.S. I'm not subscribed to the lkml ...


