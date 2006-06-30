Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWF3SJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWF3SJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932996AbWF3SJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:09:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43493 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932995AbWF3SJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:09:11 -0400
Date: Fri, 30 Jun 2006 19:09:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/softirq.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630180907.GB321@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060630113421.GX19712@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630113421.GX19712@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 01:34:22PM +0200, Adrian Bunk wrote:
> This patch marks an unused export as EXPORT_UNUSED_SYMBOL.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-mm4-full/kernel/softirq.c.old	2006-06-30 04:26:44.000000000 +0200
> +++ linux-2.6.17-mm4-full/kernel/softirq.c	2006-06-30 04:27:03.000000000 +0200
> @@ -311,7 +311,7 @@
>  	softirq_vec[nr].action = action;
>  }
>  
> -EXPORT_SYMBOL(open_softirq);
> +EXPORT_UNUSED_SYMBOL(open_softirq);  /*  June 2006  */

This should just go away ASAP.  softirq numbers are allocated statically
so no one can actually use it without patching the kernel.

