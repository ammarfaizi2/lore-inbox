Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVBQXXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVBQXXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVBQXWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:22:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:44457 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261242AbVBQXWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:22:24 -0500
Subject: Re: [PATCH 2/2] page table iterators
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050217230342.GA3115@wotan.suse.de>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>
	 <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>
	 <20050217230342.GA3115@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 10:21:03 +1100
Message-Id: <1108682463.28873.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-18 at 00:03 +0100, Andi Kleen wrote:

> And to be honest we only have about 6 or 7 of these walkers
> in the whole kernel. And 90% of them are in memory.c
> While doing 4level I think I changed all of them around several
> times and it wasn't that big an issue.  So it's not that we
> have a big pressing problem here... 

We have about 50% of them in memory.c :) But my main problem is more
that every single of them is implemented slightly differently.

Going Nick's way is a good start. If they are all consolidated to use
the same macro, they will be easier for you to change later on anyway.

Ben.


