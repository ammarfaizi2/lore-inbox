Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265054AbRF0Qyj>; Wed, 27 Jun 2001 12:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265317AbRF0Qya>; Wed, 27 Jun 2001 12:54:30 -0400
Received: from mail.aslab.com ([205.219.89.194]:33650 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S265054AbRF0QyS>;
	Wed, 27 Jun 2001 12:54:18 -0400
Date: Wed, 27 Jun 2001 09:54:06 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Gunther Mayer <Gunther.Mayer@t-online.de>, linux-kernel@vger.kernel.org,
        dhinds@zen.stanford.edu
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <E15FDSD-00052S-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.04.10106270927070.21460-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

It is an issue that we have been trying to get fixed, and only after
obsoleting ATA-2 did their attention at CFA become alarmed.  I agree that
there needs to be a fix, but not at the price of locking the rest of the
driver.  Since we now the identity of the device prior to assigned the
interrupt we can handle the execption, but you do not go around blanket
wacking the control register of all devices.

You know yourself first and all the screwed up ATAPI products that are
still using SFF-8020 that has been obsoleted before I start maintaining
the subsystem three plus years ago. 

The only way to get hardware fixed is to point out is broken and force the
issue.

I have one of these broken device with me, but I quit using it because of
that hardware flaw, mostly because I did not have the time to deal with
CFA and there lameness to follow the rules even when huge amounts of time
have passed between the notification and execution of obsolesense (sp).

Since David claims it is a known error we need to take the dirty list in
ide.c dealing with CFA's that are detected by name strings or correctly
putting in the CFA signature in word0 of identify.

I have no problem in fixing it, just blanket chopper gunning is not always
safe.

Cheers,

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

On Wed, 27 Jun 2001, Alan Cox wrote:

> > I can not help if you have a device that not compliant to the rules.
> > ATA-2 is OBSOLETED thus we forced (the NCITS Standards Body) the CFA
> 
> ATA-2 may be obsolete but existing ATA-2 hardware doesnt spontaenously
> combust when the spec changes (much Im sure to some vendors dissappointmnent)
> 

