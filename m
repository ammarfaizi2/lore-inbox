Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWKLNuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWKLNuS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbWKLNuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:50:18 -0500
Received: from il.qumranet.com ([62.219.232.206]:23783 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932610AbWKLNuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:50:17 -0500
Message-ID: <45572697.7040909@qumranet.com>
Date: Sun, 12 Nov 2006 15:50:15 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
References: <200611112334.28889.bero@arklinux.org> <4556D9C0.3050103@qumranet.com> <200611121443.52887.bero@arklinux.org>
In-Reply-To: <200611121443.52887.bero@arklinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> The attached patch makes it compile (but I'm not 100% sure it's the right 
> thing to do, I'm not very experienced with gcc-style asm).
>   
> ------------------------------------------------------------------------
>
> --- linux-2.6.18/drivers/kvm/kvm_main.c.ark	2006-11-12 14:40:09.000000000 +0100
> +++ linux-2.6.18/drivers/kvm/kvm_main.c	2006-11-12 14:38:51.000000000 +0100
> @@ -150,12 +150,12 @@
>  
>  static void load_fs(u16 sel)
>  {
> -	asm ("mov %0, %%fs" : : "g"(sel));
> +	asm ("mov %0, %%fs" : : "m"(sel));
>  }
>  
>  static void load_gs(u16 sel)
>  {
> -	asm ("mov %0, %%gs" : : "g"(sel));
> +	asm ("mov %0, %%gs" : : "m"(sel));
>  }
>  
>  #ifndef load_ldt
>   

Does "rm" instead of "m" work as well?


-- 
error compiling committee.c: too many arguments to function

