Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbSJKIZw>; Fri, 11 Oct 2002 04:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262151AbSJKIZw>; Fri, 11 Oct 2002 04:25:52 -0400
Received: from packet.digeo.com ([12.110.80.53]:18636 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262139AbSJKIZv>;
	Fri, 11 Oct 2002 04:25:51 -0400
Message-ID: <3DA68C5F.43888A19@digeo.com>
Date: Fri, 11 Oct 2002 01:31:27 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] serial8250_init premature release
References: <Pine.LNX.4.44.0210110034170.13310-100000@montezuma.mastecende.com> <20021011092314.A3062@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2002 08:31:31.0506 (UTC) FILETIME=[99DBE920:01C27100]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Oct 11, 2002 at 12:35:41AM -0400, Zwane Mwaikambo wrote:
> > --- linux-2.5.41-mm/drivers/serial/8250.c.orig        2002-10-11 00:33:09.000000000 -0400
> > +++ linux-2.5.41-mm/drivers/serial/8250.c     2002-10-11 00:33:11.000000000 -0400
> > @@ -2051,7 +2051,7 @@
> >  }
> >  #endif
> >
> > -int __init serial8250_init(void)
> > +int serial8250_init(void)
> >  {
> >       int ret, i;
> >       static int didit = 0;
> >
> 
> This doesn't apply to my tree.  serial8250_init should not be called at
> any other time than initialisation.
> 

Ah, so that's why I was Cc'ed ;)

The kgdb patch calls that function later on.
