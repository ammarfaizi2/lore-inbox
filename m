Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131335AbRCHM0M>; Thu, 8 Mar 2001 07:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131339AbRCHM0C>; Thu, 8 Mar 2001 07:26:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:34291 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131335AbRCHMZu>; Thu, 8 Mar 2001 07:25:50 -0500
Date: Thu, 8 Mar 2001 09:24:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Andrew Morton <andrewm@uow.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Questions - Re: [PATCH] documentation for mm.h
In-Reply-To: <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0103080923310.1409-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Anton Altaparmakov wrote:
> At 22:33 07/03/2001, Rik van Riel wrote:
> [snip]
> >  typedef struct page {
> >+       struct list_head list;          /* ->mapping has some page lists. */
> >+       struct address_space *mapping;  /* The inode (or ...) we belong to. */
> >+       unsigned long index;            /* Our offset within mapping. */
>
> Assuming index is in bytes (it looks like it is): Shouldn't index of type

It's in units of PAGE_CACHE_SIZE. I've corrected the documentation.

> [snip]
> >+ * During disk I/O, PG_locked is used. This bit is set before I/O
> >+ * and reset when I/O completes. page->wait is a wait queue of all
> >+ * tasks waiting for the I/O on this page to complete.
>
> Is this physical I/O only or does it include a driver
> writing/reading the page?

I'm not sure ... anyone ?

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

