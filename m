Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269133AbUHaUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbUHaUYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUHaUYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:24:12 -0400
Received: from mail.dif.dk ([193.138.115.101]:33453 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269133AbUHaUV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:21:29 -0400
Date: Tue, 31 Aug 2004 22:27:24 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, digilnux@dgii.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm2: char/pcxx.c doesn't compile
In-Reply-To: <20040831201720.GP3466@fs.tum.de>
Message-ID: <Pine.LNX.4.61.0408312225260.2702@dragon.hygekrogen.localhost>
References: <20040830235426.441f5b51.akpm@osdl.org> <20040831174102.GF3466@fs.tum.de>
 <Pine.LNX.4.61.0408312215240.2702@dragon.hygekrogen.localhost>
 <20040831201720.GP3466@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004, Adrian Bunk wrote:

> On Tue, Aug 31, 2004 at 10:18:10PM +0200, Jesper Juhl wrote:
> > On Tue, 31 Aug 2004, Adrian Bunk wrote:
> > 
> > >  static void pcxxpoll(unsigned long dummy)
> > >  {
> > > @@ -1995,6 +1982,7 @@
> > >  	volatile struct board_chan *bc;
> > >  	unsigned long flags;
> > >  	int mflag = 0;
> > > +	int mstat;
> > >  
> > >  	if(ch)
> > >  		bc = ch->brdchan;
> > > @@ -2069,6 +2057,7 @@
> > >  	pcxxparam(tty,ch);
> > >  	memoff(ch);
> > >  	restore_flags(flags);
> > > +	return 0;
> > >  }
> > 
> > since pcxxpoll is declared with a void return, return 0; here seems 
> > pointless. A simple return;  or just falling off the end of the function 
> > should be fine as far as I can see.
> 
> These two chunks are _not_ in pcxxpoll.
> 
> It might look this way in the diff output, but we are already 500 lines 
> and many functions below pcxxpoll.
> 
Yeah, the diff output tricked me - looking at the actual file I see the 
above doesn't match pcxxpoll. I should have looked there before replying. 
Sorry about that.

--
Jesper Juhl <juhl-lkml@dif.dk>

