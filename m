Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269996AbRHETau>; Sun, 5 Aug 2001 15:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269997AbRHETak>; Sun, 5 Aug 2001 15:30:40 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:14315 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S269996AbRHETab>; Sun, 5 Aug 2001 15:30:31 -0400
Date: Sun, 5 Aug 2001 15:30:37 -0400
Message-Id: <200108051930.f75JUbb11611@moisil.badula.org>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Manolis Perakakis <perakakis@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RBEM56G-100 card
In-Reply-To: <20010803180844.56139.qmail@web12908.mail.yahoo.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.6-ac5 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001 11:08:44 -0700 (PDT), Manolis Perakakis <perakakis@yahoo.com> wrote:

> see :
> http://pcmcia-cs.sourceforge.net/ftp/SUPPORTED.CARDS
>        [ Not recommended: support is experimental and
> unreliable ]
>        IBM EtherJet CardBus with 56K Modem
>        Xircom RBEM56G-100BTX, CBEM56G-100BTX, R2BEM56G-100
> 
> The same is stated at Xircom's Linux Page
> http://www.xircom.com/cda/page/0,1298,0-0-1_20-476,00.html
> 
> So, would you still recomend the purchase of such a
> card? (I wouldn't hesitate for REM56G-100BTX but 
> laptop comes with RBEM56G allready!)

Not really. The card works all right with my latest development
driver (not yet in 2.4.x), but *only* in half-duplex mode. We 
don't have enough information to make full-duplex work correctly.

The card also has a rather suboptimal design. It accepts only
32-bit aligned buffers for Tx, which forces the driver to memcpy
all the Tx packets into new (and properly aligned) buffers.

So, basically, avoid this card if you have a choice.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
