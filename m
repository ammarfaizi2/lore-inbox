Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbTIQTye (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbTIQTyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:54:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:49035 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262642AbTIQTyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:54:32 -0400
Date: Wed, 17 Sep 2003 12:53:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <richard.brunner@amd.com>
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
In-Reply-To: <3F67E8D4.6010707@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0309171251070.2523-100000@laptop.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Sep 2003, Nick Piggin wrote:
> 
> What is intriguing to me is the "Its only a 2% slowdown of the page
> fault for every cpu other than K[78] for this single workaround. There
> is no point to conditional compilation" attitude some people have.

I wouldn't worry about performance as much as correctness. I'm a lot more
worried about the notion of taking recursive pagefaults than about 2%.

Which means that I think the code should be disabled on non-buggy 
hardware. Not becuase of the 2%, but because it just exposes the potential 
of new bugs.

		Linus

