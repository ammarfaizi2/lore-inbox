Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRBJRgT>; Sat, 10 Feb 2001 12:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131622AbRBJRf7>; Sat, 10 Feb 2001 12:35:59 -0500
Received: from www.wen-online.de ([212.223.88.39]:44814 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131607AbRBJRfu>;
	Sat, 10 Feb 2001 12:35:50 -0500
Date: Sat, 10 Feb 2001 18:35:30 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.21.0102101030000.2378-100000@duckman.distro.conectiva>
Message-ID: <Pine.Linu.4.10.10102101805380.562-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Rik van Riel wrote:

> On Sat, 10 Feb 2001, Marcelo Tosatti wrote:
> > On Sat, 10 Feb 2001, Mike Galbraith wrote:
> > 
> > > This change makes my box swap madly under load.
> > 
> > Swapped out pages were not being counted in the flushing limitation.
> > 
> > Could you try the following patch? 
> 
> Marcelo's patch should do the trick wrt. to making page_launder()
> well-behaved again.  It should fix the problems some people have
> seen with bursty swap behaviour.

It's still reluctant to shrink cache.  I'm hitting I/O saturation
at 20 jobs vs 30 with ac5.  (difference seems to be the delta in
space taken by cache.. ~same space shows as additional swap volume).

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
