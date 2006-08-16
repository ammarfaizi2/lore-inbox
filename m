Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWHPRSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWHPRSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWHPRSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:18:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:4745 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750775AbWHPRSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:18:41 -0400
Date: Wed, 16 Aug 2006 10:17:47 -0700
From: Greg KH <greg@kroah.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
Message-ID: <20060816171747.GC27898@kroah.com>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33C3F.3010509@sw.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:39:43PM +0400, Kirill Korotaev wrote:
> --- ./include/asm-sparc/unistd.h.arsys	2006-07-10 12:39:19.000000000 +0400
> +++ ./include/asm-sparc/unistd.h	2006-08-10 17:08:19.000000000 +0400
> @@ -318,6 +318,9 @@
> #define __NR_unshare		299
> #define __NR_set_robust_list	300
> #define __NR_get_robust_list	301
> +#define __NR_getluid		302
> +#define __NR_setluid		303
> +#define __NR_setublimit		304

Hm, you seem to be ignoring this:

> 
> #ifdef __KERNEL__
> /* WARNING: You MAY NOT add syscall numbers larger than 301, since

Same thing for sparc64:

> --- ./include/asm-sparc64/unistd.h.arsys	2006-07-10 
> 12:39:19.000000000 +0400
> +++ ./include/asm-sparc64/unistd.h	2006-08-10 17:09:24.000000000 +0400
> @@ -320,6 +320,9 @@
> #define __NR_unshare		299
> #define __NR_set_robust_list	300
> #define __NR_get_robust_list	301
> +#define __NR_getluid		302
> +#define __NR_setluid		303
> +#define __NR_setublimit		304
> 
> #ifdef __KERNEL__
> /* WARNING: You MAY NOT add syscall numbers larger than 301, since

You might want to read those comments...

thanks,

greg k-h
