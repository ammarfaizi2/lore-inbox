Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSLTWJr>; Fri, 20 Dec 2002 17:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSLTWJr>; Fri, 20 Dec 2002 17:09:47 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:8455 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265725AbSLTWJr>; Fri, 20 Dec 2002 17:09:47 -0500
Date: Fri, 20 Dec 2002 22:17:50 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 vesafb -- no display
In-Reply-To: <20021220220534.GB2512@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0212202215090.11087-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > vesafb still shows nothing on HP OmniBook. It worked in 2.5.49, IIRC,
> > > and works on Toshiba.
> > 
> > Let me guess. You are using vga=791. Try changing that to another
> > > mode. 
> 
> Whats so bad with 791?

I haven't figured it out but we do have a theory.

In cfbimgblt.c in function color_imageblit you will see

unsigned long *palette = (unsigned long *) p->pseudo_palette;


Change that to 

u32 *palette = (u32 *) p->pseudo_palette;

Tell me if this fixes your problem.


