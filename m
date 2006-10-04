Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWJDUP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWJDUP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWJDUP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:15:29 -0400
Received: from gw.goop.org ([64.81.55.164]:5767 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751058AbWJDUP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:15:29 -0400
Message-ID: <45241659.301@goop.org>
Date: Wed, 04 Oct 2006 13:15:21 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Judith Lebzelter <judith@osdl.org>
CC: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] use-generic-bug-for-ppc
References: <20061004184927.GH665@shell0.pdx.osdl.net>
In-Reply-To: <20061004184927.GH665@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judith Lebzelter wrote:
> Index: linux/arch/ppc/kernel/traps.c
> ===================================================================
> --- linux.orig/arch/ppc/kernel/traps.c	2006-10-03 16:11:26.461653713 -0700
> +++ linux/arch/ppc/kernel/traps.c	2006-10-04 10:00:21.198907987 -0700
> @@ -28,6 +28,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/prctl.h>
> +#include <linux/bug.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/uaccess.h>
> @@ -568,55 +569,9 @@
>   */
>  extern struct bug_entry __start___bug_table[], __stop___bug_table[];
>  
> -#ifndef CONFIG_MODULES
> -#define module_find_bug(x)	NULL
> -#endif
>   
Looks like you need to delete a bit more here - the extern struct 
bug_entry, and the comment above.
    J
