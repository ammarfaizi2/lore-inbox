Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSIEOnO>; Thu, 5 Sep 2002 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSIEOnO>; Thu, 5 Sep 2002 10:43:14 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:34833 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S317603AbSIEOnN>; Thu, 5 Sep 2002 10:43:13 -0400
Date: Thu, 5 Sep 2002 09:47:50 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed
In-Reply-To: <200209051435.g85EZZ6H022915@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.44.0209050937100.10556-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Horst von Brand wrote:

> Mike Isely <isely@pobox.com> said:
> > On Thu, 5 Sep 2002, Henning P. Schmiedehausen wrote:
> > 
> > > Mike Isely <isely@pobox.com> writes:
> > > 
> > > >The trivial patch at the end of this text fixes DMA w/ LBA48 problems
> > > 
> > > More readable would be:
> > > 
> > > >-		if (!hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246) {
> > > >+		if (!(hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246)) {
> > > 
> > > 		if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
> > > 
> > 
> > Yes that is true.  But this is Andre's code and it seemed to me to be
> > more important to follow his style.  But whatever...
> 
> What is wrong with != here?

Nothing whatsoever.  If I wrote the code I would have used "!=".  But
when editing code written by someone else I try to adopt that person's
style, for better or for worse.  Using !(a == b) is more obtuse but it
is still unambiguous and readable.  So I didn't feel it was that big of
a deal to leave it in that form.  Besides, there are many MANY other
places in that driver far worse than this - just try to follow the code
that sets up DMA operations or look at the mostly dead code which tries
to identify if it is a cause for an asserted interrupt.  If we want to
start nitpicking issues as small as this then I invite you to inspect
the rest of pdc202xx.c.  Have the antacids ready...

But in the future, if I post more fixes to the IDE driver (probably 
won't), I'll sanitize as I go along.

I find it amusing that a post from me which describes evidence of
completely broken Promise controller DMA goes unresponded to, yet there
are concerns about whether to spell code as "a != b" or "!(a == b)".

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

