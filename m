Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271886AbTGRWTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271882AbTGRWO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:14:58 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49598
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271873AbTGRWMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:12:46 -0400
Date: Sat, 19 Jul 2003 00:27:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030718222750.GL3928@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random> <20030718191853.A11052@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718191853.A11052@infradead.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 07:18:53PM +0100, Christoph Hellwig wrote:
> On Thu, Jul 17, 2003 at 12:28:57PM +0200, Andrea Arcangeli wrote:
> > Only in 2.4.21rc8aa1: 9910_shm-largepage-13.gz
> > Only in 2.4.22pre6aa1: 9910_shm-largepage-16.gz
> > 
> > 	Thanks to Hugh for the help in porting the bigpages
> > 	to the rewritten shmfs layer in 22pre. No idea at the moment if it
> > 	works or if it only compiles.
> 
> Any reason you don't use a backport of hugetlbfs like the IA64 or
> the RH AS3 tree?

bigpages= is a documented API that has to be used in production, so I
can easily add the hugetlbfs API but I guess I've to keep this one
anyways. I also would need to verify the performance of hugetlbfs before
suggesting migrating to it, for example I don't want
preallocation/prefaulting (IIRC hugetlbfs preallocates everything). I
also like the single huge array of page pointers, that is very hardwired
but optimal for those workloads.

Andrea
