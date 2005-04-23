Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVDWXiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVDWXiw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVDWXiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:38:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:26063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262179AbVDWXis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:38:48 -0400
Date: Sat, 23 Apr 2005 16:35:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport __print_symbol
Message-Id: <20050423163518.2dac351c.akpm@osdl.org>
In-Reply-To: <20050415151022.GD5456@stusta.de>
References: <20050415151022.GD5456@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> I didn't find any possible modular usage in the kernel.
> 

Making print_symbol() available to modules during their development might
aid that development.  Presumably, such debug code would not appear in the
mainline tree.

IOW: people might want to use print_symbol() during private development, so
we should continue to export it to modules.


> 
> --- linux-2.6.11-rc5-mm1-full/kernel/kallsyms.c.old	2005-03-04 00:49:34.000000000 +0100
> +++ linux-2.6.11-rc5-mm1-full/kernel/kallsyms.c	2005-03-04 00:49:49.000000000 +0100
> @@ -408,4 +408,3 @@
>  }
>  __initcall(kallsyms_init);
>  
> -EXPORT_SYMBOL(__print_symbol);
