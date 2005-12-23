Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030693AbVLWRSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030693AbVLWRSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 12:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbVLWRSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 12:18:25 -0500
Received: from waste.org ([64.81.244.121]:1252 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030693AbVLWRSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 12:18:24 -0500
Date: Fri, 23 Dec 2005 11:16:28 -0600
From: Matt Mackall <mpm@selenic.com>
To: Dave Jones <davej@redhat.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] Add memcpy32 function
Message-ID: <20051223171628.GP3356@waste.org>
References: <1135301759.4212.76.camel@serpentine.pathscale.com> <20051223024943.GC27537@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223024943.GC27537@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 09:49:43PM -0500, Dave Jones wrote:
> On Thu, Dec 22, 2005 at 05:35:59PM -0800, Bryan O'Sullivan wrote:
>  > In response to the comments that followed Roland Dreier posting our
>  > InfiniPath driver for review last week, we've been making some cleanups
>  > to our driver code.
>  > 
>  > As our chip requires 32-bit accesses, we need a copy function that
>  > guarantees operating in such terms.  It was suggested that we make this
>  > generic, with arch-specific optimised versions.
>  > 
>  > This patch introduces the generic copy routine, memcpy32.  At Andrew's
>  > suggestion, I've put it in a new header file, include/linux/io.h, which
>  > I've styled after include/linux/string.h.
> 
> io.h is a very generic sounding name for something that just houses
> a memcpy variant.  What's wrong with calling a spade a spade,
> and using memcpy32.h ?

I think it belongs in string.h alongside memcpy, just for tradition's
sake. I don't think it belongs in a file named io.h, as it probably
has uses beyond I/O.

-- 
Mathematics is the supreme nostalgia of our time.
