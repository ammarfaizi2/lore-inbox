Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSLaQOG>; Tue, 31 Dec 2002 11:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbSLaQOF>; Tue, 31 Dec 2002 11:14:05 -0500
Received: from shay.ecn.purdue.edu ([128.46.209.11]:23273 "EHLO
	shay.ecn.purdue.edu") by vger.kernel.org with ESMTP
	id <S264644AbSLaQOF>; Tue, 31 Dec 2002 11:14:05 -0500
From: Kevin Corry <corry@ecn.purdue.edu>
Message-Id: <200212311622.gBVGMS5R028448@shay.ecn.purdue.edu>
Subject: Re: [PATCH] dm.c : Check memory allocations
To: joe@fib011235813.fsnet.co.uk (Joe Thornber)
Date: Tue, 31 Dec 2002 11:22:28 -0500 (EST)
Cc: dm-devel@sistina.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021230105114.GB2703@reti> from "Joe Thornber" at Dec 30, 2002 10:51:14 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, Dec 27, 2002 at 04:55:31PM -0500, Kevin Corry wrote:
> > Check memory allocations when cloning bio's.
> 
> Rejected, clone_bio() cannot fail since it's allocating from a mempool
> with __GFP_WAIT set.
> 
> - Joe

Hmm. Yep. I must have mistaken GFP_NOIO for GFP_ATOMIC.

But based on that reasoning, shouldn't the bio_alloc() call
in split_bvec() always return a valid bio, and hence make the
checks in split_bvec() and __clone_and_map() unnecessary?

Kevin

