Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161327AbWALVxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161327AbWALVxF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161328AbWALVxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:53:05 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:41229 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161327AbWALVxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:53:04 -0500
Date: Thu, 12 Jan 2006 22:52:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Matthew Wilcox <willy@parisc-linux.org>, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/parisc/Makefile: remove GCC_VERSION
Message-ID: <20060112215237.GC8665@mars.ravnborg.org>
References: <20060112105157.GT29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112105157.GT29663@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:51:57AM +0100, Adrian Bunk wrote:
> This patch removes the usage of GCC_VERSION from arch/parisc/Makefile.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I assume the parisc people will take this one.

	Sam
> 
> --- linux-2.6.15-mm3-hppa/arch/parisc/Makefile.old	2006-01-12 03:11:45.000000000 +0100
> +++ linux-2.6.15-mm3-hppa/arch/parisc/Makefile	2006-01-12 03:12:35.000000000 +0100
> @@ -35,12 +35,8 @@
>  
>  OBJCOPY_FLAGS =-O binary -R .note -R .comment -S
>  
> -GCC_VERSION     := $(call cc-version)
> -ifneq ($(shell if [ -z $(GCC_VERSION) ] ; then echo "bad"; fi ;),)
> -$(error Sorry, couldn't find ($(cc-version)).)
> -endif
> -ifneq ($(shell if [ $(GCC_VERSION) -lt 0303 ] ; then echo "bad"; fi ;),)
> -$(error Sorry, your compiler is too old ($(GCC_VERSION)).  GCC v3.3 or above is required.)
> +ifneq ($(shell if [ $(call cc-version) -lt 0303 ] ; then echo "bad"; fi ;),)
> +$(error Sorry, your compiler is too old.  GCC v3.3 or above is required.)
>  endif
>  
>  cflags-y	:= -pipe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
