Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318726AbSHLFhj>; Mon, 12 Aug 2002 01:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318727AbSHLFhj>; Mon, 12 Aug 2002 01:37:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57609 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318726AbSHLFhi>;
	Mon, 12 Aug 2002 01:37:38 -0400
Message-ID: <3D574CD7.DF054D05@zip.com.au>
Date: Sun, 11 Aug 2002 22:51:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/21] batched addition of pages to the LRU
References: <3D57449E.4FADF44@zip.com.au> <Pine.LNX.4.44L.0208120222420.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sun, 11 Aug 2002, Andrew Morton wrote:
> 
> > And it only takes one dirty block!  Any LRU page which is dirty
> > against a blocked queue is like a hand grenade floating
> > down a stream [1].  If some innocent task tries to write that
> > page it gets DoSed via the request queue.
> 
> This is exactly why we shouldn't wait on dirty pages in
> the pageout path.

It's not the wait-on-writeback which is the problem.  It's
the writeout.   Perhaps that's what you meant.
