Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbSLKOPS>; Wed, 11 Dec 2002 09:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbSLKOPS>; Wed, 11 Dec 2002 09:15:18 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:19651 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267160AbSLKOPR>; Wed, 11 Dec 2002 09:15:17 -0500
Date: Wed, 11 Dec 2002 07:16:04 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: "David S. Miller" <davem@redhat.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: atyfb in 2.5.51
In-Reply-To: <1039596149.24691.2.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've always stated that the whole fbdev model was flawed, it makes
> basic assumptions about how a video card's memory and registers are
> accessed (ie. the programming model) and many popular cards absolutely
> do not fit into that model.

I agree that the design of the /dev/fbX interface is not the best.
Unfortunely we are stuck with it. Changing it would break userland apps.

> > I will have to go threw the X code to fix that :-(
>
> There is nothing to fix.  You simply must restore the video state when
> the last mmap() client goes away.  The __sparc__ code does exactly that.

I should of worded that better. Meaning I have to see what X is doing so
the fbdev driver sets the state itself better. Hm. I'm thinking about the
mmap approach versus the fb_open approach being used now.

> I think relying on an application that mmap's a card to perfectly
> restore the state would work in a perfect world, one we do not live
> in.  Furthermore, fixing up the state like I am suggesting makes life
> much simpler for people actually working on things like X servers and
> other programs directly programming the ATI chip.

:-( True. We should always assume X or any userland app could be broken.

