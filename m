Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVDOXms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVDOXms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVDOXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:42:48 -0400
Received: from kanga.kvack.org ([66.96.29.28]:27101 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262365AbVDOXmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:42:42 -0400
Date: Fri, 15 Apr 2005 19:42:13 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O
Message-ID: <20050415234213.GC11761@kvack.org>
References: <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org> <20050407114302.GA13363@infradead.org> <29082.1113581624@redhat.com> <1113604974.27810.75.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113604974.27810.75.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 03:42:54PM -0700, Trond Myklebust wrote:
> AFAICS You grab the wait_queue_t lock once in down()/__mutex_lock()
> order to try to take the lock (or queue the waiter if that fails), then
> once more in order to pass the mutex on to the next waiter on
> up()/mutex_unlock(). That is more or less the exact same thing I was
> doing with iosems using bog-standard waitqueues, and which Ben has
> adapted to his mutexes. What am I missing?

I didn't quite see that either.

What about the use of atomic operations on frv?  Are they more lightweight 
than a semaphore, making for a better fastpath?

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
