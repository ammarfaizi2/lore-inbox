Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269134AbUHaUYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269134AbUHaUYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUHaUTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:19:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15096 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269135AbUHaUR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:17:28 -0400
Date: Tue, 31 Aug 2004 22:17:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, digilnux@dgii.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm2: char/pcxx.c doesn't compile
Message-ID: <20040831201720.GP3466@fs.tum.de>
References: <20040830235426.441f5b51.akpm@osdl.org> <20040831174102.GF3466@fs.tum.de> <Pine.LNX.4.61.0408312215240.2702@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408312215240.2702@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 10:18:10PM +0200, Jesper Juhl wrote:
> On Tue, 31 Aug 2004, Adrian Bunk wrote:
> 
> >  static void pcxxpoll(unsigned long dummy)
> >  {
> > @@ -1995,6 +1982,7 @@
> >  	volatile struct board_chan *bc;
> >  	unsigned long flags;
> >  	int mflag = 0;
> > +	int mstat;
> >  
> >  	if(ch)
> >  		bc = ch->brdchan;
> > @@ -2069,6 +2057,7 @@
> >  	pcxxparam(tty,ch);
> >  	memoff(ch);
> >  	restore_flags(flags);
> > +	return 0;
> >  }
> 
> since pcxxpoll is declared with a void return, return 0; here seems 
> pointless. A simple return;  or just falling off the end of the function 
> should be fine as far as I can see.

These two chunks are _not_ in pcxxpoll.

It might look this way in the diff output, but we are already 500 lines 
and many functions below pcxxpoll.

> Jesper Juhl <juhl-lkml@dif.dk>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

