Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbULVBnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbULVBnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 20:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbULVBnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 20:43:31 -0500
Received: from siaag2ae.compuserve.com ([149.174.40.135]:20550 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261586AbULVBn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 20:43:29 -0500
Date: Tue, 21 Dec 2004 20:40:47 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Increase page fault rate by prezeroing V1 [1/3]:
  Introduce __GFP_ZERO
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200412212043_MC3-1-916E-5C5E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004 at 11:56:07 -0800 Christoph Lameter wrote:

> --- linux-2.6.9.orig/include/asm-i386/page.h  2004-12-17 14:40:16.000000000 -0800
> +++ linux-2.6.9/include/asm-i386/page.h       2004-12-21 10:19:37.000000000 -0800
> @@ -20,6 +20,7 @@
> 
>  #define clear_page(page)     mmx_clear_page((void *)(page))
>  #define copy_page(to,from)   mmx_copy_page(to,from)
> +#define zero_page(page, order)       mmx_zero_page(page, order)
> 
>  #else
> 
> @@ -29,6 +30,7 @@
>   */
> 
>  #define clear_page(page)     memset((void *)(page), 0, PAGE_SIZE)
> +#define zero_page(page, ordeR)       memset((void *)(page), 0, PAGE_SIZE << order)

 Oops - - - - - - - - - - - - -^

>  #define copy_page(to,from)   memcpy((void *)(to), (void *)(from), PAGE_SIZE)
> 
> #endif

--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
