Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262382AbREUDza>; Sun, 20 May 2001 23:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbREUDzK>; Sun, 20 May 2001 23:55:10 -0400
Received: from www.wen-online.de ([212.223.88.39]:56849 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262382AbREUDzJ>;
	Sun, 20 May 2001 23:55:09 -0400
Date: Mon, 21 May 2001 05:54:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.21.0105201756550.5547-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0105210544390.465-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Marcelo Tosatti wrote:

> On Sat, 19 May 2001, Mike Galbraith wrote:
>
> > @@ -1054,7 +1033,7 @@
> >  				if (!zone->size)
> >  					continue;
> >
> > -				while (zone->free_pages < zone->pages_low) {
> > +				while (zone->free_pages < zone->inactive_clean_pages) {
> >  					struct page * page;
> >  					page = reclaim_page(zone);
> >  					if (!page)
>
>
> What you're trying to do with this change ?

Just ensuring that I never had a large supply of cleaned pages laying
around at a time when folks are in distress.  It also ensures that you
never donate your last reclaimable pages, but that wasn't the intent.

It was a stray though that happened to produce measurable improvement.

	-Mike

