Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSFCUzQ>; Mon, 3 Jun 2002 16:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSFCUzQ>; Mon, 3 Jun 2002 16:55:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:15622 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315529AbSFCUzO>; Mon, 3 Jun 2002 16:55:14 -0400
Date: Mon, 3 Jun 2002 17:41:39 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/16] list_head debugging
In-Reply-To: <20020603135534.GA7668@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.LNX.4.44L.0206031740550.24135-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Jan Harkes wrote:

> >  static __inline__ void list_del(struct list_head *entry)
> >  {
> >  	__list_del(entry->prev, entry->next);
> > +	/*
> > +	 * This is debug.  Remove it when the kernel has no bugs ;)
> > +	 */
> > +	entry->next = 0;
> > +	entry->prev = 0;
> >  }
>
> We've had this before, and it breaks some code that removes items from
> lists as follows,

Such code is probably not SMP safe anyway.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

