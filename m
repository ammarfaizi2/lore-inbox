Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSFSRan>; Wed, 19 Jun 2002 13:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317948AbSFSRam>; Wed, 19 Jun 2002 13:30:42 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:7437 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317947AbSFSRal>; Wed, 19 Jun 2002 13:30:41 -0400
Date: Wed, 19 Jun 2002 14:18:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH] (2/2) reverse mappings for current 2.5.23 VM
In-Reply-To: <E17Kipf-0000uu-00@starship>
Message-ID: <Pine.LNX.4.44L.0206191417290.2598-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Daniel Phillips wrote:

> > > 2.5.23-rmap (this patch -- "rmap-minimal"):
> > > Total kernel swapouts during test = 24068 kB
> > > Total kernel swapins during test  =  6480 kB
> > > Elapsed time for test: 133 seconds
> > >
> > > 2.5.23-rmap13b (Rik's "rmap-13b complete") :
> > > Total kernel swapouts during test = 40696 kB
> > > Total kernel swapins during test  =   380 kB
> > > Elapsed time for test: 133 seconds

> You might conclude from the above that the lru+rmap is superior to
> aging+rmap: while they show the same wall-clock time, lru+rmap consumes
> considerably less disk bandwidth.  Naturally, it would be premature to
> conclude this from one trial on one load.

On the contrary, aging+rmap shows a lot less swapins.

The fact that it has more swapouts than needed means
we need to fix one aspect of the thing (page_launder),
it doesn't mean we should get rid of the whole thing.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

