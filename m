Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270615AbRHNM7T>; Tue, 14 Aug 2001 08:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270614AbRHNM67>; Tue, 14 Aug 2001 08:58:59 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:12037 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270612AbRHNM6v>; Tue, 14 Aug 2001 08:58:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VM working much better in 2.4.8 than before
Date: Tue, 14 Aug 2001 15:03:51 +0200
X-Mailer: KMail [version 1.3]
Cc: Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108131245200.6118-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108131245200.6118-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010814125859Z16031-1231+838@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 13, 2001 05:52 pm, Rik van Riel wrote:
> On Mon, 13 Aug 2001, Alan Cox wrote:
> > > Yes, those would be the expected effects of use-once, in fact it was
> > > "morning after updatedb" question that got me started on it.
> >
> > updatedb is also absolutely fine if you just work with the existing VM
> > and up the inode pressure a little. I'm still very unconvinced by
> > use-once.
> 
> Use-once has a number of theoretical disadvantages too:
> 
> 1) newly read in pages are evicted earlier, this means
>    readahead pages will either evict each other or the
>    amount of readahead done might need to be shrunk
>    -- the current readahead code is not prepared for this,
>       use-once could lead to more disk seeks being done

Have you actually seen this happening?
 
> 2) since we add new pages to the inactive list, VM
>    balancing is faced with a really strange situation ;)
> 
> Yes, these things are solvable, but not without redesigning
> major parts of the VM balancing to do things which have never
> been done before. I'm not sure 2.4 is the time to do that.

--
Daniel
