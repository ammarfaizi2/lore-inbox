Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbUKQR1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbUKQR1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbUKQR0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:26:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:32651 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262432AbUKQRZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:25:53 -0500
Message-ID: <419B869B.5030603@osdl.org>
Date: Wed, 17 Nov 2004 09:12:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] trivial, uninline do_trap(), remove get_cr2()
References: <419B64C2.CED2FABC@tv-sign.ru>
In-Reply-To: <419B64C2.CED2FABC@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> Uninlining do_trap() saves 544 bytes in traps.o.
> get_cr2() seems to be unused, remove it.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.10-rc2/arch/i386/kernel/traps.c~	Tue Nov 16 14:13:08 2004
> +++ 2.6.10-rc2/arch/i386/kernel/traps.c	Wed Nov 17 16:47:41 2004
> @@ -358,16 +358,7 @@ static inline void die_if_kernel(const c
>  		die(str, regs, err);
>  }
>  
> -static inline unsigned long get_cr2(void)
> -{
> -	unsigned long address;
> -
> -	/* get the address */
> -	__asm__("movl %%cr2,%0":"=r" (address));
> -	return address;
> -}

Looks like it can be removed from arch/x86_64/kernel/traps.c also.

-- 
~Randy
