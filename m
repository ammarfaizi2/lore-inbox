Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265152AbRF0Uuu>; Wed, 27 Jun 2001 16:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbRF0Uuk>; Wed, 27 Jun 2001 16:50:40 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:14856 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265152AbRF0Uu1>; Wed, 27 Jun 2001 16:50:27 -0400
Message-ID: <3B3A4748.D7B9168C@t-online.de>
Date: Wed, 27 Jun 2001 22:51:20 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@aslab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <Pine.LNX.4.04.10106271244130.21460-100000@mail.aslab.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> PARANIOA.

This is not a valid reason.

This clearly fixes a bug in linux. Note: the irq disable
is local to ide-cs. Are you paranoid enough to believe
enabling the irq by writing globally to the control register that
existed since ATA will have ill effects? 

You claim the relevant PCMCIA ATA behaviour is not ATA(>3?) compliant,
however you didn`t yet give any facts to support this !

You claim this locks the driver, again no facts.


> 
> Remember that ATAPI is generally screwed beyond reality, so adjusting the
> probe code in general (global) is a bad thing.
...
> On Wed, 27 Jun 2001, Alan Cox wrote:
> 
> > > obsoleting ATA-2 did their attention at CFA become alarmed.  I agree that
> > > there needs to be a fix, but not at the price of locking the rest of the
> > > driver.  Since we now the identity of the device prior to assigned the
> > > interrupt we can handle the execption, but you do not go around blanket
> > > wacking the control register of all devices.

The proposed patch is very simple (as per Linus' liking). When considering to
install an earlier (and  global) irq handler I believe you can see
this will impose a much greater risk !

> >
> > I dont see why it locks up the driver ?
