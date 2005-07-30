Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbVG3SQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVG3SQM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbVG3SNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:13:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263096AbVG3SNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:13:00 -0400
Date: Sat, 30 Jul 2005 11:08:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-Id: <20050730110800.0db305f1.akpm@osdl.org>
In-Reply-To: <20050730165202.GI5590@stusta.de>
References: <20050730165202.GI5590@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Currently, using an undeclared function gives a compile warning, but it 
> can lead to a link or even a runtime error.
> 
> With -Werror-implicit-function-declaration, we are getting an immediate 
> compile error instead.
> 
> This patch also removes some unneeded spaces between two tabs in the 
> following line.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.13-rc3-mm3-full/Makefile.old	2005-07-30 13:55:32.000000000 +0200
> +++ linux-2.6.13-rc3-mm3-full/Makefile	2005-07-30 13:55:56.000000000 +0200
> @@ -351,7 +351,8 @@
>  CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
>  
>  CFLAGS 		:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> -	  	   -fno-strict-aliasing -fno-common \
> +		   -Werror-implicit-function-declaration \
> +		   -fno-strict-aliasing -fno-common \
>  		   -ffreestanding
>  AFLAGS		:= -D__ASSEMBLY__
>  

heh.  Nice idea, but if I merge this I'll have tons of monkey work to do
to get ppc64, ia64 and others compiling :(

umm, so what to do?  I'm inclined to just slam it in post-2.6.13 then take
a week off or something.
