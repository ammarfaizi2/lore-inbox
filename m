Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUIVUSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUIVUSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUIVURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:17:43 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:43012 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267365AbUIVUPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:15:20 -0400
Message-ID: <4151DF1F.2050202@techsource.com>
Date: Wed, 22 Sep 2004 16:22:55 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, jmerkey@comcast.net,
       alan@lxorguk.ukuu.org.uk, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
References: <083020040556.26446.4132C1810009E19F0000674E2200751150970A059D0A0306@comcast.net>	<20040830111019.5ddc99ab.rddunlap@osdl.org>	<4151C9FB.8040100@techsource.com> <52r7oukuh5.fsf@topspin.com>
In-Reply-To: <52r7oukuh5.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roland Dreier wrote:
>     Timothy> My question is: Why can't we just shrink the kernel
>     Timothy> address space by that same amount, allowing the kernel
>     Timothy> address space plus the extra to fit into 1GB?
> 
> If you have 1 GB of memory and want to map it all into the kernel's
> address space and the kernel has only 1 GB of address space total,
> then there is no room for anything else (such as address space to
> ioremap memory-mapped peripherals or space for vmalloc allocations).
> Therefore, if you want to have 1 GB of RAM mapped linearly into the
> kernel's address space, you need strictly more than 1 GB of kernel
> address space.  In practice, 1.25 GB of kernel address space (a
> PAGE_OFFSET value of 0xb0000000) works well with 1 GB of RAM.  That's
> what I run on my main desktop machine with 1 GB of RAM to avoid HIGHMEM.
> 
>  - Roland
> 
> 


Ok, I understand now.  I think.  With 0xc0000000, you have 128M of 
highmem, right?  Why do you add 256M to the kernel address space?  Is 
there a further advantage to that?

