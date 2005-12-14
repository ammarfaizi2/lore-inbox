Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVLNWYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVLNWYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVLNWYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:24:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965029AbVLNWYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:24:00 -0500
Date: Wed, 14 Dec 2005 14:22:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-Id: <20051214142216.57d1900a.akpm@osdl.org>
In-Reply-To: <20051214221304.GE23349@stusta.de>
References: <20051214191006.GC23349@stusta.de>
	<20051214140531.7614152d.akpm@osdl.org>
	<20051214221304.GE23349@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> CC_OPTIMIZE_FOR_SIZE is still an experimental feature that doesn't work 
> with all supported gcc/architecture combinations.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-git/init/Kconfig.old	2005-12-14 23:08:51.000000000 +0100
> +++ linux-git/init/Kconfig	2005-12-14 23:09:09.000000000 +0100
> @@ -257,7 +257,7 @@
>  source "usr/Kconfig"
>  
>  config CC_OPTIMIZE_FOR_SIZE
> -	bool "Optimize for size"
> +	bool "Optimize for size (EXPERIMENTAL)" if EXPERIMENTAL
>  	default y if ARM || H8300
>  	help
>  	  Enabling this option will pass "-Os" instead of "-O2" to gcc

This will cause arm and h8300 to accidentally stop using -Os if they have
!EXPERIMENTAL.
