Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRFQRgY>; Sun, 17 Jun 2001 13:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRFQRgO>; Sun, 17 Jun 2001 13:36:14 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:8720 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S262170AbRFQRgC>; Sun, 17 Jun 2001 13:36:02 -0400
Subject: Re: a memory-related problem?
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: klink@clouddancer.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010617131002.EF84D784BD@mail.clouddancer.com>
In-Reply-To: <CDEJIPDFCLGDNEHGCAJPOEFGCCAA.rbultje@ronald.bitfreak.net>
	<9gi848$pb2$1@ns1.clouddancer.com> 
	<20010617131002.EF84D784BD@mail.clouddancer.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 17 Jun 2001 21:26:50 +0200
Message-Id: <992806021.2007.0.camel@tux.bitfreak.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 2001 06:10:02 -0700, Colonel wrote:
> In clouddancer.list.kernel, you wrote:
> >
> >Hi,
> >
> >I just added 128 MB of RAM to my machine which already had 128 MB and
> >which has 128 MB swap. 128 MB RAM + 128 MB swap (either the new or the
> >old 128 MB RAM) works, but the combination of that, 256 MB RAM + 128 MB
> >swap, crashes the compu during startup with either an "unresolved-
> >symbols in init" message (which is completely random, each boot shows
> >different unresolved references) or with oopses right after starting
> >init.
> 
> It's more likely that the two RAM sticks differ.  I had a similar
> problem in a Windoze machine awhile ago.  Move one stick of RAM into
> another bank, i.e. with 4 memory slots, use #1 and #3.  If you only
> have 2 memory slots, return/sell what you have and buy 2 sticks at the
> same time.

P6b has three mem-slots. I would get "unresolved errors in init" if I
had 2x64+1x128 sticks, and I would get oopses if I had 2x128M sticks. So
there is indeed a weird difference.
I just noticed this: if I supply "linux-2.4.4 mem=255M" instead of
"linux-2.4.4 mem=256M" at the lilo prompt, it does work. Is this a bug
in the code that handles options given at startup-time? (I only tried
this for 2x128 sticks but I suppose this is the same for 2x64+1x128
sticks - I guess I'm too lazy to try it out).

Regards,

Ronald Bultje

