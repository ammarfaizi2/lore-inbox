Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264034AbRFEQxe>; Tue, 5 Jun 2001 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264040AbRFEQxY>; Tue, 5 Jun 2001 12:53:24 -0400
Received: from inje.iskon.hr ([213.191.128.16]:52894 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S264039AbRFEQxN>;
	Tue, 5 Jun 2001 12:53:13 -0400
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Comment on patch to remove nr_async_pages limit
In-Reply-To: <Pine.LNX.4.33.0106050820540.867-100000@mikeg.weiden.de>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 05 Jun 2001 17:57:45 +0200
In-Reply-To: <Pine.LNX.4.33.0106050820540.867-100000@mikeg.weiden.de> (Mike Galbraith's message of "Tue, 5 Jun 2001 09:38:08 +0200 (CEST)")
Message-ID: <873d9ezzpi.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:

> On Mon, 4 Jun 2001, Marcelo Tosatti wrote:
> 
> > Zlatko,
> >
> > I've read your patch to remove nr_async_pages limit while reading an
> > archive on the web. (I have to figure out why lkml is not being delivered
> > correctly to me...)
> >
> > Quoting your message:
> >
> > "That artificial limit hurts both swap out and swap in path as it
> > introduces synchronization points (and/or weakens swapin readahead),
> > which I think are not necessary."
> >
> > If we are under low memory, we cannot simply writeout a whole bunch of
> > swap data. Remember the writeout operations will potentially allocate
> > buffer_head's for the swapcache pages before doing real IO, which takes
> > _more memory_: OOM deadlock.
> 
> What's the point of creating swapcache pages, and then avoiding doing
> the IO until it becomes _dangerous_ to do so?  That's what we're doing
> right now.  This is a problem because we guarantee it will become one.
> We guarantee that the pagecache will become almost pure swapcache by
> delaying the writeout so long that everything else is consumed.
> 

Huh, this looks just like my argument, just put in different words. I
should have read this sooner. :)
-- 
Zlatko
