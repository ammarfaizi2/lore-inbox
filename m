Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSJMQ6m>; Sun, 13 Oct 2002 12:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSJMQ6m>; Sun, 13 Oct 2002 12:58:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28109 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261550AbSJMQ6l>; Sun, 13 Oct 2002 12:58:41 -0400
Date: Sun, 13 Oct 2002 22:40:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: Linux v2.5.42
Message-ID: <20021013224000.A13043@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com> <20021012144322.A17332@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021012144322.A17332@infradead.org>; from hch@infradead.org on Sat, Oct 12, 2002 at 01:46:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 01:46:17PM +0000, Christoph Hellwig wrote:
> BTW, there's another infrastructure feature I forgot when you asked
> what should go in before feature freeze.  And IMHO it's very important
> (so why did I forget it..):  IBM's read copy update synchronisation
> primitives.  They've shown significant improvements when used for the
> file tables, dcache and routing cache, it has been around since before
> 2.5 forked, SuSE has it in their production kernel for a while, too and 
> akpm has it in his tree for while.

Yes, rcu core and dcache_rcu has been in -mm since 2.5.37-mm1 and we
haven't seen any problems with it so far. This patch combination
has no regression in lower end of systems and gives us better performance in
webserver and multiuser type of workloads at the higher end of systems.

> Even if those existing users don't get in yet I don't want to miss the
> infrastructure in the 2.6 series.

Andrew, will you be inclined to send this to Linus or should I send them
myself ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
