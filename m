Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWE1R3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWE1R3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWE1R3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:29:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:30710 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750807AbWE1R3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:29:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JXkek/eTTANNn0O7JFUQ8SxGvmEsptsVTyKYei8NuUIIclIEj/pevEDxk2pnnHbvgOlNu8AOnZqiB4evdVAFzVfsAop1e0CgwznLoMploWrP0QFpKaoKRBetBF8CwJCep3EW9E8RflzqPv56CNcinY7Q2c9ptSe9X5VnCYCzJPs=
Message-ID: <84144f020605281029q1fa6ed59jb415ffb9a7daeef9@mail.gmail.com>
Date: Sun, 28 May 2006 20:29:21 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Paul Drynoff" <pauldrynoff@gmail.com>
Subject: Re: [PATCH] mm/comments: kmalloc man page before 2.6.17 (the third attempt)
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060528111446.55572c6f.pauldrynoff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060528111446.55572c6f.pauldrynoff@gmail.com>
X-Google-Sender-Auth: 34eb9d1ef53f4c24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since no one else seems to have complained about this...

On 5/28/06, Paul Drynoff <pauldrynoff@gmail.com> wrote:
> +/**
> + * kmalloc - allocate memory
> + * @size: how many bytes of memory are required.
> + * @flags: the type of memory to allocate.
> + *
> + * kmalloc is the normal method of allocating memory
> + * in the kernel.
> + *
> + * The @flags argument may be one of:
> + *
> + * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> + *
> + * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> + *
> + * %GFP_ATOMIC - Allocation will not sleep.
> + *   For example: use inside interrupt handlers.
> + * %GFP_HIGHUSER - Allocate pages from high memory.
> + * %GFP_NOIO - Do not do any I/O at all while trying to get memory.
> + * %GFP_NOFS - Do not make any fs calls while trying to get memory.

Why are the last four formatted differently from the first two?  That
is, a newline seems to be missing.

> + *
> + *
> + * Also it is possible set different flags by OR'ing
> + * in one or more of the following:
> + * %__GFP_COLD
> + *  - Request cache-cold pages instead of trying to return cache-warm pages.
> + * %__GFP_DMA
> + *  - Request memory from the DMA-capable zone.
> + * %__GFP_HIGH
> + *  - This allocation has high priority and may use emergency pools.
> + * %__GFP_HIGHMEM
> + *   - Allocated memory may be from highmem.
> + * %__GFP_NOFAIL
> + *  - Indicate that this allocation is in no way allowed to fail
> + * (think twice before using).
> + * %__GFP_NORETRY
> + * - If memory is not immediately available, then give up at once.
> + * %__GFP_NOWARN
> + * - If allocation fails, don't issue any warnings.
> + * %__GFP_REPEAT
> + * - If allocation fails initially, try once more before failing.

And why do these have completely different formatting?  Please pick
one and use that consistently.

                                 Pekka
