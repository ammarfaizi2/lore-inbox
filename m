Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131310AbRCHKwV>; Thu, 8 Mar 2001 05:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131311AbRCHKwM>; Thu, 8 Mar 2001 05:52:12 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:29663 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131310AbRCHKwD>; Thu, 8 Mar 2001 05:52:03 -0500
Date: Thu, 8 Mar 2001 11:51:37 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Questions - Re: [PATCH] documentation for mm.h
Message-ID: <20010308115137.M27675@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0103071931400.1409-100000@duckman.distro.con ectiva> <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Thu, Mar 08, 2001 at 10:11:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 10:11:50AM +0000, Anton Altaparmakov wrote:
> At 22:33 07/03/2001, Rik van Riel wrote:
> [snip]
> >  typedef struct page {
> >+       struct list_head list;          /* ->mapping has some page lists. */
> >+       struct address_space *mapping;  /* The inode (or ...) we belong to. */
> >+       unsigned long index;            /* Our offset within mapping. */
> 
> Assuming index is in bytes (it looks like it is): 

isn't. To get the byte offset, you have to multiply it by PAGE_{CACHE_,}SIZE.

> [snip]
> >+ * During disk I/O, PG_locked is used. This bit is set before I/O
> >+ * and reset when I/O completes. page->wait is a wait queue of all
> >+ * tasks waiting for the I/O on this page to complete.
> 
> Is this physical I/O only or does it include a driver writing/reading the page?

Depends on the method of the driver, that is getting called.
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
