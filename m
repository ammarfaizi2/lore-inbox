Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVDJN7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVDJN7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVDJN7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:59:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31127 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261499AbVDJN7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:59:39 -0400
Date: Sun, 10 Apr 2005 19:38:58 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O
Message-ID: <20050410140858.GB4001@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org> <20050407114302.GA13363@infradead.org> <20050408223927.GA22217@kvack.org> <1113003106.10596.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113003106.10596.46.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Apr 08, 2005 at 07:31:46PM -0400, Trond Myklebust wrote:
> fr den 08.04.2005 Klokka 18:39 (-0400) skreiv Benjamin LaHaise:
> 
> > On the aio side of things, I introduced the owner field in the mutex (as 
> > opposed to the flag in Trond's iosem) for the next patch in the series to 
> > enable something like the following api:
> > 
> > 	int aio_lock_mutex(struct mutex *lock, struct iocb *iocb);
> 
> Any chance of a more generic interface too?
> 
> iocbs are fairly high level objects, and so I do not see them helping to
> resolve low level filesystem problems such as the NFSv4 state cleanup.

My preferred approach would be to make the wait queue element the
primitive, rather than the iocb, precisely for this reason.

Guess its time for me to repost my aio-wait-bit based patch set - it
doesn't cover the async semaphores bit, but should indicate the general
direction of thinking.

I still need to look at Ben's patches though.

Regards
Suparna

> 
> Cheers,
>   Trond
> 
> -- 
> Trond Myklebust <trond.myklebust@fys.uio.no>
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

