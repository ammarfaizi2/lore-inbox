Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbRETItd>; Sun, 20 May 2001 04:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbRETItY>; Sun, 20 May 2001 04:49:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:31757 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261488AbRETItP>;
	Sun, 20 May 2001 04:49:15 -0400
Date: Sun, 20 May 2001 05:49:09 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105200957500.323-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105200546241.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Mike Galbraith wrote:

> You're right.  It should never dump too much data at once.  OTOH, if
> those cleaned pages are really old (front of reclaim list), there's no
> value in keeping them either.  Maybe there should be a slow bleed for
> mostly idle or lightly loaded conditions.

If you don't think it's worthwhile keeping the oldest pages
in memory around, please hand me your excess DIMMS ;)

Remember that inactive_clean pages are always immediately
reclaimable by __alloc_pages(), if you measured a performance
difference by freeing pages in a different way I'm pretty sure
it's a side effect of something else.  What that something
else is I'm curious to find out, but I'm pretty convinced that
throwing away data early isn't the way to go.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

