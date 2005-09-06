Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVIFGei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVIFGei (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVIFGei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:34:38 -0400
Received: from web33806.mail.mud.yahoo.com ([66.163.178.53]:42108 "HELO
	web33806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932417AbVIFGeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:34:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GKNnNRW1kvVPggjBMqnLsH1T8csda0AItBFa+bUjtCgsA0Eq31Q7K4iiPruqAtnJEqNn0wuDWc4DSbo7gAdyjyk65qwczqVetniEbJScmOVvCOJrNa38YFE3wDIwUjHpRFw8rzVDjcBYPN6x6x2Cy5/TnDjjgaHTCnOQZClwUx4=  ;
Message-ID: <20050906063416.17001.qmail@web33806.mail.mud.yahoo.com>
Date: Tue, 6 Sep 2005 07:34:16 +0100 (BST)
From: Mehul Vora <mehul_linux@yahoo.com>
Subject: Re: netif_rx for ATM
To: manomugdha biswas <manomugdhab@yahoo.co.in>, linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
In-Reply-To: <20050906041604.50601.qmail@web8505.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
  For submitting an sk_buff to upper layer you have to
use atm_vcc structure, provided by kernel. This has
one "push" entry point where you can pass your skbuff
structure. go through drivers/atm/zatm.c.

Mehul.


--- manomugdha biswas <manomugdhab@yahoo.co.in> wrote:

> 
> 
>  Hi,
>  I am writing a new driver module for ATM. I want to
>  send a packet to protocol stack using netif_rx().
>  For
>  ethernet i am using netif_rx() in the following
> way.
>  I
>  have dev pointer.
>  
>    skbuff->dev = device; 
>    skbuff->protocol = eth_type_trans(skbuff,
> device);
>  
>    netif_rx(skbuff); 
>  
>  It works for ethernet and POS and does not work for
>  ATM. Could anyone please tell me what to do for
> ATM?
>  
>  Regards,
>  Mano
>  
>  
> > Manomugdha Biswas
> > 
> > 
> > 	
> > 
> > 	
> > 		
> >
>
__________________________________________________________
> > 
> > Yahoo! India Matrimony: Find your partner online.
> Go
> > to http://yahoo.shaadi.com
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> Manomugdha Biswas
> 
> 
> 	
> 
> 	
> 		
>
__________________________________________________________
> 
> Yahoo! India Matrimony: Find your partner online. Go
> to http://yahoo.shaadi.com
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Send instant messages to your online friends http://uk.messenger.yahoo.com 
