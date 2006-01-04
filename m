Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWADXWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWADXWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWADXWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:22:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751818AbWADXWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:22:42 -0500
Date: Wed, 4 Jan 2006 15:24:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Better diagnostics for broken configs
Message-Id: <20060104152433.7304ec75.akpm@osdl.org>
In-Reply-To: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.15/arch/um/include/choose-mode.h
> ===================================================================
> --- linux-2.6.15.orig/arch/um/include/choose-mode.h	2005-08-28 19:41:01.000000000 -0400
> +++ linux-2.6.15/arch/um/include/choose-mode.h	2005-11-17 10:43:47.000000000 -0500
> @@ -23,6 +23,9 @@ static inline void *__choose_mode(void *
>  
>  #elif defined(UML_CONFIG_MODE_TT)
>  #define CHOOSE_MODE(tt, skas) (tt)
> +
> +#else
> +#error CONFIG_MODE_SKAS and CONFIG_MODE_TT are both disabled
>  #endif
>  
>  #define CHOOSE_MODE_PROC(tt, skas, args...) \

Is there no sane way to prevent this situation within Kconfig?
