Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269817AbRHTXW5>; Mon, 20 Aug 2001 19:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269822AbRHTXWr>; Mon, 20 Aug 2001 19:22:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:23045 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269817AbRHTXWf>; Mon, 20 Aug 2001 19:22:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Tue, 21 Aug 2001 01:29:11 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108201839580.538-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108201839580.538-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820232242Z16361-32385+84@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 11:50 pm, Marcelo Tosatti wrote:
> On Tue, 21 Aug 2001, Daniel Phillips wrote:

> > If you've seen streaming IO pages getting evicted before being used,
> > I'd like to know about it because something is broken in that case.
> 
> I've seen the first page read by "swapin_readahead()" (which is the actual
> page we want to swapin) be evicted _before_ we could actually use it (so
> the read_swap_cache_async() call had to read the same page _again_ from
> disk).

It's not streaming IO, but whoops, is that even with yesterday's 
SetPageReferenced patch to do_swap_page?

--
Daniel
