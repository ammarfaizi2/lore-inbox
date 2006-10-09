Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWJKLKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWJKLKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWJKLKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:10:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42249 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751204AbWJKLKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:10:10 -0400
Date: Mon, 9 Oct 2006 19:35:35 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: it's OK to pass pointer to volatile as iounmap() argument...
Message-ID: <20061009193534.GA4358@ucw.cz>
References: <20061009010949.GJ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009010949.GJ29920@ftp.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -361,14 +361,14 @@ __ioremap(unsigned long phys_addr, size_
>  }
>  EXPORT_SYMBOL(__ioremap);
>  
> -void __iounmap(void __iomem *addr)
> +void __iounmap(volatile void __iomem *addr)

Who is crazy enough to pass volatile pointers here? I guess they should be
fixed, instead.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
