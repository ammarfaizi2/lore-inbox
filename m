Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267815AbTBNX0r>; Fri, 14 Feb 2003 18:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267993AbTBNX0r>; Fri, 14 Feb 2003 18:26:47 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:16256 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267815AbTBNX0q>; Fri, 14 Feb 2003 18:26:46 -0500
Message-ID: <3E4D7D38.AA998C3F@cinet.co.jp>
Date: Sat, 15 Feb 2003 08:35:20 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.60-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (12/34) console
References: <Pine.LNX.4.44.0302121735580.31435-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments.

James Simmons wrote:
> 
> > > --- linux/drivers/char/console_macros.h     Sat Oct 19 13:01:17 2002
> > > +++ linux98/drivers/char/console_macros.h   Mon Oct 28 16:53:39 2002
> > > @@ -55,6 +55,10 @@
> > >  #define    s_reverse       (vc_cons[currcons].d->vc_s_reverse)
> > >  #define    ulcolor         (vc_cons[currcons].d->vc_ulcolor)
> > >  #define    halfcolor       (vc_cons[currcons].d->vc_halfcolor)
> > > +#define def_attr   (vc_cons[currcons].d->vc_def_attr)
> > > +#define ul_attr            (vc_cons[currcons].d->vc_ul_attr)
> > > +#define half_attr  (vc_cons[currcons].d->vc_half_attr)
> > > +#define bold_attr  (vc_cons[currcons].d->vc_bold_attr)
> >
> > Bah, console_macros.h should just die.
> 
> Agree. Next developement series it will.
How do I know your chnages? Please points me. URL? ML archive?
This means writing directly them into source file?
 
> > Please set CONFIG_KANJI in the Kconfig file and in general
> > the CONFIG_KANJI usere look really messy.  I don't think it's
> > easy to get them cleaned up before 2.6, you might get in contact
> > with James who works on the console layer to properly integrate them.
> 
> I doubt it. The console system is designed around VGA text mode. It will
> be lots of #ifdef to get it to work. Just a bad mess. I plan someday to
> rework the console system to handle all these cases.
For difference of VRAM mapping, I implemented scr_* function family.
But codes for difference of attribute value remains in mainline sources.
And I need many #if for support japanese character.
How do you think about 2bytes character support?
I think, If kernel suports 2bytes character, many people useing japanese 
chinese korean... may be happy.

Regards,
Osamu Tomita
