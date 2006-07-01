Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWGADhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWGADhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWGADhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:37:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8935 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932242AbWGADhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:37:43 -0400
Date: Fri, 30 Jun 2006 20:34:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/printk.c: EXPORT_SYMBOL_UNUSED
Message-Id: <20060630203430.4f2690bf.akpm@osdl.org>
In-Reply-To: <20060630113137.GJ19712@stusta.de>
References: <20060630113137.GJ19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:31:37 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> This patch marks unused exports as EXPORT_SYMBOL_UNUSED.
> 
> -EXPORT_SYMBOL(console_printk);
> +EXPORT_UNUSED_SYMBOL(console_printk);  /*  June 2006  */
> -EXPORT_SYMBOL(is_console_locked);
> +EXPORT_UNUSED_SYMBOL(is_console_locked);  /*  June 2006  */

OK.

> -EXPORT_SYMBOL(__printk_ratelimit);
> +EXPORT_UNUSED_SYMBOL(__printk_ratelimit);  /*  June 2006  */

It's a generalised and more useful version of printk_ratelimit() - worth
keeping.

