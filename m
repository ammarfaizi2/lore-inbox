Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVAaQyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVAaQyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAaQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:54:05 -0500
Received: from waste.org ([216.27.176.166]:62934 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261262AbVAaQx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:53:59 -0500
Date: Mon, 31 Jan 2005 08:53:55 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Message-ID: <20050131165355.GO2891@waste.org>
References: <200501311352.57234.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501311352.57234.adobriyan@mail.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 01:52:57PM +0200, Alexey Dobriyan wrote:
> On Mon, 31 Jan 2005 01:34:59 -0600, Matt Mackall wrote:
> 
> > This patch adds a generic array sorting library routine. This is meant
> > to replace qsort, which has two problem areas for kernel use.
> 
> > --- /dev/null
> > +++ mm2/include/linux/sort.h
> > @@ -0,0 +1,8 @@
> 
> > +void sort(void *base, size_t num, size_t size,
> > +	  int (*cmp)(const void *, const void *),
> > +	  void (*swap)(void *, void *, int));
> 
> extern void sort(...) ?

Extern is 100% redundant on function declarations.

> P. S.: Andrew's email ends with ".org".

I should not mail off patches just before going to sleep.

-- 
Mathematics is the supreme nostalgia of our time.
