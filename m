Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752013AbWHNMVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbWHNMVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbWHNMVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:21:23 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:44485 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752013AbWHNMVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:21:22 -0400
Date: Mon, 14 Aug 2006 16:20:50 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Keith Owens <kaos@ocs.com.au>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060814122049.GC18321@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <9286.1155557268@ocs10w.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <9286.1155557268@ocs10w.ocs.com.au>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 14 Aug 2006 16:20:51 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:07:48PM +1000, Keith Owens (kaos@ocs.com.au) wrote:
> Evgeniy Polyakov (on Mon, 14 Aug 2006 15:04:03 +0400) wrote:
> >Network tree allocator can be used to allocate memory for all network
> >operations from any context....
> >...
> >Design of allocator allows to map all node's pages into userspace thus
> >allows to have true zero-copy support for both sending and receiving
> >dataflows.
> 
> Is that true for architectures with virtually indexed caches?  How do
> you avoid the cache aliasing problems?

Pages are preallocated and stolen from main memory allocator, what is
the problem with that caches? Userspace can provide enough offset so
that pages would not create aliases - it is usuall mmap.

-- 
	Evgeniy Polyakov
