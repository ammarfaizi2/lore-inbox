Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTH0UJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 16:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbTH0UJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 16:09:26 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:32974 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262057AbTH0UJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 16:09:24 -0400
Date: Wed, 27 Aug 2003 13:09:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4] make log buffer length selectable
Message-ID: <20030827200922.GH32065@ip68-0-152-218.tc.ph.cox.net>
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030826042550.GJ734@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826042550.GJ734@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 06:25:50AM +0200, Willy Tarreau wrote:
> On Mon, Aug 25, 2003 at 04:48:30AM -0700, Marcelo Tosatti wrote:
> > final:
> > 
> > - 2.4.22-rc4 was released as 2.4.22 with no changes.
> 
> Hi Marcelo,
> 
> as you requested, here is the log_buf_len patch for inclusion in 23-pre.

Two things.  First, why not ask on every arch like 2.6 does?  Second:
> diff -urN wt10-pre3/kernel/printk.c wt10-pre3-log-buf-len/kernel/printk.c
> --- wt10-pre3/kernel/printk.c	Wed Mar 19 09:58:20 2003
> +++ wt10-pre3-log-buf-len/kernel/printk.c	Tue Mar 25 08:14:55 2003
> @@ -29,6 +29,7 @@
>  
>  #include <asm/uaccess.h>
>  
> +#if !defined(CONFIG_LOG_BUF_SHIFT) || (CONFIG_LOG_BUF_SHIFT - 0 == 0)

Why not just || (CONFIG_LOG_BUF_SHIFT == 0) ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
