Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbSLFAD0>; Thu, 5 Dec 2002 19:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbSLFACN>; Thu, 5 Dec 2002 19:02:13 -0500
Received: from dp.samba.org ([66.70.73.150]:46285 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267463AbSLFACB>;
	Thu, 5 Dec 2002 19:02:01 -0500
Date: Fri, 6 Dec 2002 11:08:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206000809.GT1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
References: <3DEF9196.6010002@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEF9196.6010002@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 06:49:10PM +0100, Manfred Spraul wrote:
> >
> >
> >Hmm... that doesn't seem sufficient to explain it.
> >
> >Some background: I work with PPC embedded chips (the 4xx family) whose
> >only way to get consistent memory is by entirely disabling the cache.

> What do you mean with "disable"?
> Do you have to disable the cache entirely when you encounter the first 
> pci_alloc_consistent() call, or do you disable the cache just for the 
> region that is returned by pci_alloc_consistent()?

Just for the region - it is an attribute in the PTE.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
