Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbTLRSPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 13:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbTLRSPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 13:15:13 -0500
Received: from intra.cyclades.com ([64.186.161.6]:8591 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265280AbTLRSOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 13:14:40 -0500
Date: Thu, 18 Dec 2003 16:02:49 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Patrick Mau <mau@oscar.ping.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] page_alloc.c is missing a ')'
In-Reply-To: <20031217113652.GA25893@oscar.prima.de>
Message-ID: <Pine.LNX.4.44.0312181601090.14081-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Right, fixed in BK.

Thanks 

On Wed, 17 Dec 2003, Patrick Mau wrote:

> Hi,
> 
> my current bk snapshot of Linus' 2.4 tree is missing a closing
> brace in page_alloc.c
> 
> Here's a patch:
> 
> --- page_alloc.c.orig	2003-12-17 12:19:54.000000000 +0100
> +++ page_alloc.c	2003-12-17 12:20:29.000000000 +0100
> @@ -379,7 +379,7 @@
>  	/* here we're in the low on memory slow path */
>  
>  	if (((current->flags & PF_MEMALLOC) && 
> -			(!in_interrupt() || (current->flags & PF_MEMDIE))) {
> +			(!in_interrupt() || (current->flags & PF_MEMDIE)))) {
>  		zone = zonelist->zones;
>  		for (;;) {
>  			zone_t *z = *(zone++);

