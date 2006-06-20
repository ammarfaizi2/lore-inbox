Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWFTN2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWFTN2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWFTN2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:28:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46812 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750798AbWFTN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:28:35 -0400
Subject: Re: [PATCH] ide: disable dma for transcend CF
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirill Smelkov <kirr@mns.spb.ru>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <200606201452.37905.kirr@mns.spb.ru>
References: <200606201452.37905.kirr@mns.spb.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jun 2006 14:43:23 +0100
Message-Id: <1150811003.11062.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 14:52 +0400, ysgrifennodd Kirill Smelkov:
> I have a CF card which identifies itself as model=TRANSCEND rev=200508011
> The card id labeled as TS512MCF80
> 
> hdparm -i /dev/hdci  reports:
> ...
> DMA modes:  mdma0 mdma1 *mdma2
> 
> IDE controller:
> IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 
> 
> but if dma is turned on i get a lot of errors::
> 
>     hdc: dma_timer_epiry: dma_status == 0x21


Almost certainly a problem with the CF adapter. Please verify the card
in a modern CF adapter and also do tests with DMA capable cards of other
types on the adapter you are using.

Back when CF adapters first appeared the idea that you might run DMA on
one was so ludicrously silly that nobody wired the neccessary pins on
the adapters. Time has moved on, but hardware alas has sometimes not.

Alan

