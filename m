Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262647AbRFBSCl>; Sat, 2 Jun 2001 14:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbRFBSCc>; Sat, 2 Jun 2001 14:02:32 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:33224 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S262647AbRFBSCS>;
	Sat, 2 Jun 2001 14:02:18 -0400
Date: Sat, 2 Jun 2001 14:00:54 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: APIC problem or 3com 3c590 driver problem in smp kernel 2.4.x
In-Reply-To: <E156DvX-0001rf-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106021357110.5655-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jun 2001, Alan Cox wrote:

> > It's our own's card. so it could be the card's problem. does the pci
> > device have to do some special thing to support APIC? my card won't work
>
> Nope. APIC is invisible to a correctly built piece of hardware. It just changes
> how INTA-INTD are handled at the host end of things
>
> > properly on uni-processor with APIC enable kernel or smp kernel when the
> > card is sharing IRQ with some other pci devices.
>
> That sounds like the driver isnt testing the irq was sourced by that card. You
> also see hangups on insmod/rmmod when people do
>
> 		writel(ENABLE_MY_IRQ, my_card->control);
>
> before they request the IRQ and are able to clear it
>

I forget to mention. in the same hardware configuration (same slot, sharing
IRQ with other card) my card works perfect if I was using uni-processor
without APIC support kernel (i tried 2.4.5-ac6 with apic disabled
uniprocessor on a dual p3 box). If the driver did something wrong, it
should not work on that system either. Maybe what I thought was wrong.

Alex

-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX

