Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTCEUNS>; Wed, 5 Mar 2003 15:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTCEUNS>; Wed, 5 Mar 2003 15:13:18 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:22542 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262420AbTCEUNP>; Wed, 5 Mar 2003 15:13:15 -0500
Date: Wed, 5 Mar 2003 20:23:45 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
In-Reply-To: <1046727094.1279.27.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303052023110.27760-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >   And one (or two...) generic questions: why is not pseudo_palette
> > u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
> 
> Yes, all drivers should treat the pseudo_palette as u32* anyway, so why
> not change pseudo-palette from void* to u32*?

See other email.

> > And why we do not fill this pseudo_palette with
> > i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> > pseudocolor? This allowed me to remove couple of switches and tests
> > from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> > but I did not changed these two in my benchmarks below).
> 
> I also agree for a different reason.  Cards with unconventional formats
> (such as monochrome at 8 bpp - 0 for black , 0xff for white) will not
> work with the current code.

Isn't that the job of setcolreg?

