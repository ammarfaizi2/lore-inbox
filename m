Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTIQFJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTIQFJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:09:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:61630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261973AbTIQFJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:09:47 -0400
Date: Tue, 16 Sep 2003 22:08:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-Id: <20030916220843.31533480.akpm@osdl.org>
In-Reply-To: <3F67E8D4.6010707@cyberone.com.au>
References: <20030917022256.GA17624@wotan.suse.de>
	<20030916194446.030d8e70.akpm@osdl.org>
	<3F67E8D4.6010707@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> What is intriguing to me is the "Its only a 2% slowdown of the page
>  fault for every cpu other than K[78] for this single workaround. There
>  is no point to conditional compilation" attitude some people have.
>  Of course, its only 2% on a pagefault, not anywhere near 2% of kernel
>  performance as a whole, so maybe that is justified.

Absolutely.  But it's a bit of a pain finding a config option which says
"this CPU might need the fixup".

>  Just repeating though, that is a seperate issue and I think Andi's patch
>  is needed.

It is unquestionably needed - the kernel _has_ to perform the fixup for this
CPU erratum.


But I would like to see some evidence that prefetch ever provides any
performance gain in-kernel.  I spent some time fiddling a while back and
was unable to demonstrate any difference.

