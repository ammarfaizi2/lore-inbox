Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTBLR2F>; Wed, 12 Feb 2003 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTBLR2F>; Wed, 12 Feb 2003 12:28:05 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:42768 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267275AbTBLR2E>; Wed, 12 Feb 2003 12:28:04 -0500
Date: Wed, 12 Feb 2003 17:37:52 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (12/34) console
In-Reply-To: <20030212153617.A10171@infradead.org>
Message-ID: <Pine.LNX.4.44.0302121735580.31435-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > --- linux/drivers/char/console_macros.h	Sat Oct 19 13:01:17 2002
> > +++ linux98/drivers/char/console_macros.h	Mon Oct 28 16:53:39 2002
> > @@ -55,6 +55,10 @@
> >  #define	s_reverse	(vc_cons[currcons].d->vc_s_reverse)
> >  #define	ulcolor		(vc_cons[currcons].d->vc_ulcolor)
> >  #define	halfcolor	(vc_cons[currcons].d->vc_halfcolor)
> > +#define def_attr	(vc_cons[currcons].d->vc_def_attr)
> > +#define ul_attr		(vc_cons[currcons].d->vc_ul_attr)
> > +#define half_attr	(vc_cons[currcons].d->vc_half_attr)
> > +#define bold_attr	(vc_cons[currcons].d->vc_bold_attr)
> 
> Bah, console_macros.h should just die.

Agree. Next developement series it will.

> Please set CONFIG_KANJI in the Kconfig file and in general
> the CONFIG_KANJI usere look really messy.  I don't think it's
> easy to get them cleaned up before 2.6, you might get in contact
> with James who works on the console layer to properly integrate them.

I doubt it. The console system is designed around VGA text mode. It will 
be lots of #ifdef to get it to work. Just a bad mess. I plan someday to 
rework the console system to handle all these cases.

