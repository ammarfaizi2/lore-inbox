Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWE3EVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWE3EVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 00:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWE3EVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 00:21:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15845 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751285AbWE3EVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 00:21:08 -0400
Date: Mon, 29 May 2006 21:20:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com,
       axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447BB3FD.1070707@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 May 2006, Nick Piggin wrote:
> 
> I guess so. Is plugging still needed now that the IO layer should
> get larger requests?

Why do you think the IO layer should get larger requests?

I really don't understand why people dislike plugging. It's obviously 
superior to non-plugged variants, exactly because it starts the IO only 
when _needed_, not at some random "IO request feeding point" boundary.

In other words, plugging works _correctly_ regardless of any random 
up-stream patterns. That's the kind of algorithms we want, we do NOT want 
to have the IO layer depend on upstream always doing the "Right 
Thing(tm)".

So exactly why would you want to remove it?

		Linus
