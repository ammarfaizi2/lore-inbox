Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUIEG2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUIEG2i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 02:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUIEG2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 02:28:38 -0400
Received: from ozlabs.org ([203.10.76.45]:45002 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266274AbUIEG2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 02:28:35 -0400
Date: Sun, 5 Sep 2004 16:27:43 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
Message-ID: <20040905062743.GG7716@krispykreme>
References: <413AA7B2.4000907@yahoo.com.au> <20040904230939.03da8d2d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904230939.03da8d2d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There have been few reports, and I believe that networking is getting
> changed to reduce the amount of GFP_ATOMIC higher-order allocation
> attempts.

FYI I seem to remember issues on loopback due to its large MTU. Also the
printk_ratelimit stuff first appeared because the e1000 was spewing so
many higher order page allocation failures on some boxes.

But yes, the e1000 guys were going to look into multiple buffer mode so
they dont need a high order allocation.

Anton
