Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVLOUdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVLOUdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVLOUdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:33:21 -0500
Received: from witte.sonytel.be ([80.88.33.193]:3481 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751045AbVLOUdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:33:20 -0500
Date: Thu, 15 Dec 2005 21:32:03 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <1134678532.13138.44.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be>
References: <20051215085602.c98f22ef.pj@sgi.com> <20051213143147.d2a57fb3.pj@sgi.com>
 <20051213094053.33284360.pj@sgi.com> <dhowells1134431145@warthog.cambridge.redhat.com>
 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
 <20051213100015.GA32194@elte.hu> <6281.1134498864@warthog.cambridge.redhat.com>
 <14242.1134558772@warthog.cambridge.redhat.com> <16315.1134563707@warthog.cambridge.redhat.com>
 <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca>
 <20051214155432.320f2950.akpm@osdl.org> <17313.29296.170999.539035@gargle.gargle.HOWL>
 <1134658579.12421.59.camel@localhost.localdomain> <4743.1134662116@warthog.cambridge.redhat.com>
 <7140.1134667736@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
 <20051215112115.7c4bfbea.akpm@osdl.org> <1134678532.13138.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005, Steven Rostedt wrote:
> On Thu, 2005-12-15 at 11:21 -0800, Andrew Morton wrote:
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > >
> > > On Thu, 15 Dec 2005, David Howells wrote:
> > >  > 
> > >  > 	FROM				TO
> > >  > 	==============================	=========================
> > >  > 	DECLARE_MUTEX			DECLARE_SEM_MUTEX
> > >  > 	DECLARE_MUTEX_LOCKED		DECLARE_SEM_MUTEX_LOCKED
> > >  > 	Proper counting semaphore	DECLARE_SEM
> > > 
> > >  That sounds fine.
> > 
> > They should be renamed to DEFINE_* while we're there.  A "declaration" is
> > "this thing is defined somewhere else".  A "definition" is "this thing is
> > defined here".
> 
> Why have the "MUTEX" part in there?  Shouldn't that just be DECLARE_SEM
> (oops, I mean DEFINE_SEM).  Especially that MUTEX_LOCKED! What is that?
> How does a MUTEX start off as locked.  It can't, since a mutex must
> always have an owner (which, by the way, helped us in the -rt patch to
> find our "compat_semaphores").  So who's the owner of a
> DEFINE_SEM_MUTEX_LOCKED?

No one. It's not really a mutex, but a completion.

Gr{oetje,eeting}s,

						Geert

P.S. Long live the common vocabulary ;-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
