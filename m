Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVJDCV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVJDCV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 22:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVJDCV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 22:21:29 -0400
Received: from xenotime.net ([66.160.160.81]:48820 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932286AbVJDCV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 22:21:28 -0400
Date: Mon, 3 Oct 2005 19:21:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] CodingStyle: memory allocation
Message-Id: <20051003192125.56325c31.rdunlap@xenotime.net>
In-Reply-To: <200510031658.j93Gw12D028566@hera.kernel.org>
References: <200510031658.j93Gw12D028566@hera.kernel.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005 09:58:01 -0700 Linux Kernel Mailing List wrote:

> tree 39f6737bb96998199144382cdb4eb867be180873
> parent f647e08a55d2c88c4e7ab17a0a8e3fcf568fbc65
> author Pekka J Enberg <penberg@cs.Helsinki.FI> Sat, 17 Sep 2005 09:28:11 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 18 Sep 2005 01:50:02 -0700
> 
> [PATCH] CodingStyle: memory allocation
> 
> This patch adds a new chapter on memory allocation to
> Documentation/CodingStyle.
> 
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>


Just curious, was this merged by dictum?
'cause it sure wasn't merged due to any concensus on this point...


>  Documentation/CodingStyle |   21 ++++++++++++++++++++-
>  1 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> --- a/Documentation/CodingStyle
> +++ b/Documentation/CodingStyle
> @@ -410,7 +410,26 @@ Kernel messages do not have to be termin
>  Printing numbers in parentheses (%d) adds no value and should be avoided.
>  
>  
> -		Chapter 13: References
> +		Chapter 13: Allocating memory
> +
> +The kernel provides the following general purpose memory allocators:
> +kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
> +documentation for further information about them.
> +
> +The preferred form for passing a size of a struct is the following:
> +
> +	p = kmalloc(sizeof(*p), ...);
> +
> +The alternative form where struct name is spelled out hurts readability and
> +introduces an opportunity for a bug when the pointer variable type is changed
> +but the corresponding sizeof that is passed to a memory allocator is not.
> +
> +Casting the return value which is a void pointer is redundant. The conversion
> +from void pointer to any other pointer type is guaranteed by the C programming
> +language.


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
