Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTCDVil>; Tue, 4 Mar 2003 16:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbTCDVil>; Tue, 4 Mar 2003 16:38:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26785
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261368AbTCDVik>; Tue, 4 Mar 2003 16:38:40 -0500
Subject: Re: [PATCH] Avoid PC(?) specific cascade dma reservation in
	kernel/dma.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Johan Adolfsson <johan.adolfsson@axis.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0303041945590.7198-100000@hydra-11.axis.se>
References: <Pine.LNX.4.21.0303041945590.7198-100000@hydra-11.axis.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046818415.12231.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Mar 2003 22:53:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 18:49, Johan Adolfsson wrote:
> I guess the reservation of dma channel 4 for "cascade" is
> PC or chipset specific and we don't have such a thing in the 
> CRIS (ETRAX100LX) chip and channel 4 clashes with external dma0.
> Perhaps a better fix is to #ifdef on something else or remove 
> the cascade stuff entirely from this file, but I leave that
> to those who know better.
> Have no other arch been bitten by this?

I don't know of any PC cards that can support ISA DMA channel 4 so I
guess simply because of that it hasn't happened. Do you actually
know of any DMA 4 capable ISA devices or is it used for onboard
ISA devices ?

The ifdef is ugly. There should be a nicer way to do this.
