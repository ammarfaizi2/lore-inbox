Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271390AbRHTQbY>; Mon, 20 Aug 2001 12:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271383AbRHTQbD>; Mon, 20 Aug 2001 12:31:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29705 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271376AbRHTQaw>; Mon, 20 Aug 2001 12:30:52 -0400
Subject: Re: sound crashes in 2.4
To: chrisp@newmail.net (Chris Pockele)
Date: Mon, 20 Aug 2001 17:33:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Chris Pockele" at Aug 20, 2001 06:17:14 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Yrzo-0006LI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have the same problems with an ALS007 card (in a 486 system).
> The card is correctly recognized and set up by the PnP drivers.

Humm. 

> The time after which it crashes is variable, sometimes it crashes
> immediately, sometimes it crashes after 5 minutes.
> Sometimes, it also stalls a few times before finally crashing.

Ok that actually sounds more like a locking bug.

> Both 2.4.8 and 2.4.9 have this problem (these are the ones I tried).
> Btw on 2.2.x i get DMA (output) timeout errors (and broken sound).

Can you try one other thing.

Edit drivers/pci/quirks.c

find 

int isa_dma_bridge_buggy;		/* Exported */

and make it read

int isa_dma_bridge_buggy = 1;

recompile reboot and see if it helps
