Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUHANwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUHANwr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUHANwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:52:47 -0400
Received: from mail.dif.dk ([193.138.115.101]:54212 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265971AbUHANwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:52:45 -0400
Date: Sun, 1 Aug 2004 15:57:17 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Peter Maydell <pmaydell@chiark.greenend.org.uk>,
       Phil Blundell <philb@gnu.org>, Andrew Morton <akpm@osdl.org>,
       Kars de Jong <jongk@linux-m68k.org>
Subject: Re: [PATCH] Fix up return value from dio_find() (fixing a FIXME)
In-Reply-To: <Pine.GSO.4.58.0408011533030.25657@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.60.0408011555290.2535@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.60.0407312132490.2660@dragon.hygekrogen.localhost>
 <Pine.GSO.4.58.0408011519180.25657@waterleaf.sonytel.be>
 <Pine.LNX.4.60.0408011530120.2535@dragon.hygekrogen.localhost>
 <Pine.GSO.4.58.0408011533030.25657@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Geert Uytterhoeven wrote:

> On Sun, 1 Aug 2004, Jesper Juhl wrote:
> > On Sun, 1 Aug 2004, Geert Uytterhoeven wrote:
> > > On Sat, 31 Jul 2004, Jesper Juhl wrote:
> > > > Here's a patch to fix up this FIXME in drivers/dio/dio.c:dio_find() :
> > > >
> > > > * Aargh: we use 0 for an error return code, but select code 0 exists!
> > > > * FIXME (trivial, use -1, but requires changes to all the drivers :-< )
> > > > */
> > > >
> > > > I've changed the return value to -1 as suggested by the comment, and then
> > > > went looking for the drivers that needed to be changed (as the comment
> > > > mentions). I only found two users of dio_find() and I've fixed those up to
> > > > not treat 0 as an error, but only values <0.
> > > > The FIXME implies (to me at least) that there are many drivers that would
> > > > need to be changed, but I could only find two - did I miss anything?
> > > > Also, I don't have the hardware to test the drivers I've changed, so I've
> > > > done compile testing only - could someone please review my changes and
> > > > confirm if they are correct?
> > >
> > > I guess most of these are already covered by Kars' patch at the URL below?
> > >
> > >     http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/474-dio.diff
> > >
> > It certainly looks that way from reading the patch. I was unaware of this
> > patch (which looks a lot more thorough than mine).  Thank you for the
> > link.
> > His patch makes the change to dio_find() , but I don't see any changes to
> > drivers/net/hplance.c or drivers/video/hpfb.c - are the changes I made
> > there not needed? those two treat a return value of 0 from dio_find() as
> > an error as far as I can tell...
> 
> These are in patches 475 and 476 next to 474 in the same dir.
> 
Ahh yes, so I see. Now why didn't I think to look there...
And once again his patches look way better than mine. :)

Ok, everyone just ignore my patch.


/Jesper

