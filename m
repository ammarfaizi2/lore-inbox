Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWEAVWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWEAVWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWEAVWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:22:51 -0400
Received: from iabervon.org ([66.92.72.58]:56076 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932265AbWEAVWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:22:50 -0400
Date: Mon, 1 May 2006 17:23:24 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
In-Reply-To: <20060430174426.a21b4614.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0605011645260.6713@iabervon.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Apr 2006, Randy.Dunlap wrote:

> + (b) Clear integer types, where the abstraction _helps_ avoid confusion
> +     whether it is "int" or "long".
> +
> +     u8/u16/u32 are perfectly fine typedefs.
> +
> +     NOTE! Again - there needs to be a _reason_ for this. If something is
> +     "unsigned long", then there's no reason to do
> +
> +	typedef long myflags_t;
> +
> +     but if there is a clear reason for why it under certain circumstances
> +     might be an "unsigned int" and under other configurations might be
> +     "unsigned long", then by all means go ahead and use a typedef.
> +
> + (c) when you use sparse to literally create a _new_ type for
> +     type-checking.

Is there an official position on "typedef unsigned __bitwise__ myflags_t"? 
That is, getting into case (c) with something not particularly useful for 
typechecking, just because you want to use a typedef. 

I don't remember if the gfp_t thing was only done because it would catch a 
very common type of bug, or if it's generally suggested for new code.

	-Daniel
*This .sig left intentionally blank*
