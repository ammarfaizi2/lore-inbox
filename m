Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262096AbRENOL6>; Mon, 14 May 2001 10:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262103AbRENOLr>; Mon, 14 May 2001 10:11:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:34063 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262096AbRENOLg>;
	Mon, 14 May 2001 10:11:36 -0400
Date: Mon, 14 May 2001 11:11:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap.c fixes
In-Reply-To: <01051415544304.02742@starship>
Message-ID: <Pine.LNX.4.21.0105141111100.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Daniel Phillips wrote:
> On Monday 14 May 2001 06:00, Rik van Riel wrote:
> 
> > +	if (!PageActive(page))
> > +		activate_page(page);
> > +	else
> > +		SetPageReferenced(page);
> > +
> 
> How about:
> 
> > +	if (PageActive(page))
> > +		SetPageReferenced(page);
> > +	else
> > +		activate_page(page);

Fine with me ...

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

