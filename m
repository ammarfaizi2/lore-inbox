Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSKKHyb>; Mon, 11 Nov 2002 02:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265660AbSKKHyb>; Mon, 11 Nov 2002 02:54:31 -0500
Received: from holomorphy.com ([66.224.33.161]:3765 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265657AbSKKHyb>;
	Mon, 11 Nov 2002 02:54:31 -0500
Date: Sun, 10 Nov 2002 23:58:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111075849.GM23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Con Kolivas <conman@kolivas.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	marcelo@conectiva.com.br
References: <3DCEC6F7.E5EC1147@digeo.com> <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com> <20021111015445.GB5343@x30.random> <3DCF2BF5.5DD165DD@digeo.com> <20021111040642.GA30193@dualathlon.random> <3DCF308E.166FAADF@digeo.com> <20021111043941.GB30193@dualathlon.random> <3DCF3BD1.4A95617D@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCF3BD1.4A95617D@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 2.5 (and read-latency) sort-of solve these problems by creating a
> massive seekstorm when there are competing reads and writes.  It's
> a pretty sad solution really.

On Sun, Nov 10, 2002 at 09:10:41PM -0800, Andrew Morton wrote:
> Better would be to perform those reads and writes in nice big batches.
> That's easy for the writes, but for reads we need to wait for the
> application to submit another one.  That means actually deliberately
> leaving the disk head idle for a few milliseconds in the anticipation
> that the application will submit another nearby read.  This is called
> "anticipatory scheduling" and has been shown to provide 20%-70%
> performance boost in web serving workloads.   It just makes heaps of
> sense to me and I'd love to see it in Linux...
> See http://www.cs.ucsd.edu/sosp01/papers/iyer.pdf

This smacks of "deceptive idleness". OTOH I prefer to keep out of those
issues and focus on pure fault handling, TLB, and space consumption
issues. I/O scheduling is far afield for me, and I prefer to keep it so.


Bill
