Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbREUCU3>; Sun, 20 May 2001 22:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbREUCUT>; Sun, 20 May 2001 22:20:19 -0400
Received: from venus.postmark.net ([207.244.122.71]:5394 "HELO
	venus.postmark.net") by vger.kernel.org with SMTP
	id <S262344AbREUCUL>; Sun, 20 May 2001 22:20:11 -0400
Message-ID: <20010521013705.4079.qmail@venus.postmark.net>
Mime-Version: 1.0
From: J Brook <jbk@postmark.net>
To: linux-kernel@vger.kernel.org
Subject: tulip driver BROKEN in 2.4.5-pre4
Date: Mon, 21 May 2001 01:37:05 +0000
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, so Jeff Garzik already knows about this - I told him last week -
but seeing as how the code has made it to a Linus pre-release without
a fix I thought I'd better post the breakage description to l-k!

The symptoms are:
In 2.4.5-pre4 (and 2.4.4-ac8 and above - note: I didn't try -ac7)
system boots up normally, card is recognised etc, but all networking
services fail because it's not possible to talk to the network. The
system appears to be stable apart from the bug (possible to compile
kernels, run X, etc.), but nothing gets to or from the network.

I'm using the "DECchip Tulip (dc21x4x) PCI support" option to get the
driver for the PCI card which has a Digital 21041 chip in it.

FWIW I think it might be related to the selection of full- or
half-duplex. 2.4.4-ac6 (which works fine) says:
  Port selection is half-duplex
when I run tulip-diag, whereas 2.4.5-pre4 says
  Port selection is full-duplex

My system is RH7.1 (using gcc-2.96 not kgcc)
Duron 750, KT133 chipset (not kt133a!)

Network card details (it is a PCI):
Kingston KNE40BT (1995)
  Digital 21041-AA  DC1017BA
  21-40756-01  Dec 1994
  S15313-02
  A 9615

 More details on request. And I'm willing to test patches...

    John
----------------
jbk@postmark.net

