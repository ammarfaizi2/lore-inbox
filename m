Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUHIV3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUHIV3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUHIV27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:28:59 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:28352 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267278AbUHIV12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:27:28 -0400
Date: Mon, 9 Aug 2004 17:31:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mpm@selenic.com
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / x86_64
In-Reply-To: <20040809132308.7312656b.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0408091726520.21726@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408072217170.19619@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0408080156550.19619@montezuma.fsmlabs.com>
 <20040809132308.7312656b.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004, Andi Kleen wrote:

> I think the 50k number is wrong. I took a look at it and the big
> difference is only seen when you enable interrupts during spinning, which
> we didn't do before.  If you compare it to the old implementation the
> difference is much less.

Yes agreed the increase wouldn't be of as high a magnitude if compared to
the original code, but it's still a decent saving.

> I don't really like the config option. Either it's a good idea
> then it should be done by default without option or it should not be done at all.
>
> Did you do any lock intensive benchmarks that could show a slowdown?

I went for a file IO type benchmark, the differences looked like
statistical noise, possibly the best bet would be to check for cache
hits/misses.

> You should make this file assembly only.

Ok you're the second person to mention that, i don't have a problem with
switching to assembly only and dumping the exports in x8664_ksyms.c

Thanks,
	Zwane

