Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbRAESHp>; Fri, 5 Jan 2001 13:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131624AbRAESHf>; Fri, 5 Jan 2001 13:07:35 -0500
Received: from hermes.mixx.net ([212.84.196.2]:60944 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130378AbRAESHV>;
	Fri, 5 Jan 2001 13:07:21 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org
Subject: Re: MM/VM todo list
Date: Fri, 5 Jan 2001 18:58:22 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101051505430.1295-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0101051505430.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01010519042301.00517@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jan 2001, Rik van Riel wrote:
> Hi,
> 
> here is a TODO list for the memory management area of the
> Linux kernel, with both trivial things that could be done
> for later 2.4 releases and more complex things that really
> have to be 2.5 things.
> 
> Most of these can be found on http://linux24.sourceforge.net/ too
> 
> Trivial stuff:
> * VM: better IO clustering for swap (and filesystem) IO
>   * Marcelo's swapin/out clustering code
>   * ->writepage() IO clustering support
>   * page_launder()/->writepage() working together in avoiding
>     low-yield (small cluster) IO at first, ...
> * VM: include Ben LaHaise's code, which moves readahead to the
>   VMA level, this way we can do streaming swap IO, complete with
>   drop_behind()
> * VM: enforce RSS ulimit
> 
> 
> Probably 2.5 era:
> * VM: physical->virtual reverse mapping, so we can do much
>   better page aging with less CPU usage spikes 
> * VM: move all the global VM variables, lists, etc. into the
>   pgdat struct for better NUMA scalability
> * VM: per-node kswapd for NUMA
> * VM: thrashing control, maybe process suspension with some
>   forced swapping ?             (trivial only in theory)
> * VM: experiment with different active lists / aging pages
>   of different ages at different rates + other page replacement
>   improvements
> * VM: Quality of Service / fairness / ... improvements
> 
> 
> Additions to this list are always welcome, I'll put it online
> on the Linux-MM pages (http://www.linux.eu.org/Linux-MM/) soon.

I'd like to suggest variable sized pages as a research topic.  It's not
clear whether we're talking 2.5 or 2.7 here.

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
