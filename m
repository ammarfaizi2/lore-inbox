Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWCXVdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWCXVdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWCXVdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:33:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4781 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750746AbWCXVdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:33:13 -0500
Date: Fri, 24 Mar 2006 13:35:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use const* parameters in mm.h
Message-Id: <20060324133528.24fecc9b.akpm@osdl.org>
In-Reply-To: <20060323221241.719662a8@werewolf.auna.net>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323220711.28fcb82f@werewolf.auna.net>
	<20060323221241.719662a8@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> As they are inline, this gives the compiler wide space for optmizations.
> 
> --- linux-2.6.15-rc5-mm2.orig/include/linux/mm.h	2005-12-12 09:10:34.000000000 -0800
> +++ linux-2.6.15-rc5-mm2/include/linux/mm.h	2005-12-14 14:39:50.000000000 -0800
> @@ -464,7 +464,7 @@ void put_page(struct page *page);
>  #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
>  #define ZONETABLE_MASK		((1UL << ZONETABLE_SHIFT) - 1)
>  
> -static inline unsigned long page_zonenum(struct page *page)
> +static inline unsigned long page_zonenum(const struct page *page)
> ...

This makes zero difference in x86 allnoconfig code size with both gcc-3.2.1
and gcc-4.1.
