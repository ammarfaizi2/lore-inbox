Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132173AbRAKFnp>; Thu, 11 Jan 2001 00:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRAKFnj>; Thu, 11 Jan 2001 00:43:39 -0500
Received: from www.wen-online.de ([212.223.88.39]:8710 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130436AbRAKFnO>;
	Thu, 11 Jan 2001 00:43:14 -0500
Date: Thu, 11 Jan 2001 06:43:07 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Jonathan Earle <jearle@nortelnetworks.com>,
        "'Linux Kernel List'" <linux-kernel@vger.kernel.org>,
        "'Linux Network List'" <linux-net@vger.kernel.org>
Subject: Re: Porting network driver to 2.4.0
In-Reply-To: <Pine.LNX.3.95.1010110155123.14197A-100000@chaos.analogic.com>
Message-ID: <Pine.Linu.4.10.10101110625540.1827-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Richard B. Johnson wrote:

> On Wed, 10 Jan 2001, Jonathan Earle wrote:
> 
> > Hey all,
> > 
> > Still working with kernel 2.4.0-test9 (other things we use require it for
> > now), and I was looking at a driver for a Znyx zx346q network card that I
> > grabbed from the znyx.com website.  The driver is for a 2.2.x kernel, but
> > figuring I'd try it anyway, downloaded and tried to build it.  It choked on
> > three struct net_device entries which are no longer present:
> >                                                   
> > zxe.c:1200: structure has no member named `tbusy'
> > zxe.c:1201: structure has no member named `interrupt'
> > zxe.c:1202: structure has no member named `start'
> > ...
> > make[2]: *** [zxe.o] Error 1                              
> > 
> > Where do I go from here?  Is there info somewhere to help with this?  Is
> > this a bigger job than it looks on the surface?
> > 
> > Cheers!
> > Jon
> 
> You may be lucky. Comment out all references to those structure members
> and see if it works!

I doubt it's possible to get _that_ lucky ;-)

IIRC, this was the conversion from struct device -> struct net_device.
(Also IIRC, interrupt was a 'toss it' item.. grep patches to be sure)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
