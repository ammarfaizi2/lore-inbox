Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTGCNeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTGCNeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 09:34:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26597
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263062AbTGCNeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 09:34:23 -0400
Date: Thu, 3 Jul 2003 15:48:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030703134821.GD23578@dualathlon.random>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 09:06:32AM -0400, Rik van Riel wrote:
> On Thu, 3 Jul 2003, Andrea Arcangeli wrote:
> 
> > even if you don't use largepages as you should, the ram cost of the pte
> > is nothing on 64bit archs, all you care about is to use all the mhz and
> > tlb entries of the cpu.
> 
> That depends on the number of Oracle processes you have.

well, that wasn't necessairly a database but ok.

> Say that page tables need 0.1% of the space of the virtual
> space they map.  With 1000 Oracle users you'd end up needing
> as much memory in page tables as your shm segment is large.

so just add more ram, ram is cheaper than cpu power (I mean, on 64bit)

> Of course, in this situation either the application should
> use large pages or the kernel should simply reclaim the

as you say, it should definitely use largepages if it's such kind of
usage, so the whole point of saving pte space is void.  it should use
largepages even if it's not "many tasks mapping the shm", but just a
single task mapping some huge ram.

> Agreed on that.  Please let the monstrosity die together
> with 32 bit machines ;)

Indeed ;)

Andrea
