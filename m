Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbUKJXw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUKJXw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbUKJXwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:52:25 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:24585 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262059AbUKJXwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:52:13 -0500
Message-ID: <4192A9BF.2080606@conectiva.com.br>
Date: Wed, 10 Nov 2004 21:52:31 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
References: <4192A959.9020806@conectiva.com.br>
In-Reply-To: <4192A959.9020806@conectiva.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/built-in.o(.text+0xeade): In function `pin_2_irq':
: undefined reference to `platform_rename_gsi'
make: ** [.tmp_vmlinux1] Erro 1

Sorry, the patch is not enough...

- Arnaldo

Arnaldo Carvalho de Melo wrote:
> Hi Linus,
> 
>     This is needed to build current BK tree on IA32.
> 
> - Arnaldo
> 
> 
> ------------------------------------------------------------------------
> 
> ===== arch/i386/kernel/io_apic.c 1.116 vs edited =====
> --- 1.116/arch/i386/kernel/io_apic.c	2004-10-28 05:35:33 -03:00
> +++ edited/arch/i386/kernel/io_apic.c	2004-11-10 21:39:57 -02:00
> @@ -1039,6 +1039,8 @@
>  	return MPBIOS_trigger(idx);
>  }
>  
> +extern int (*platform_rename_gsi)(int ioapic, int gsi);
> +
>  static int pin_2_irq(int idx, int apic, int pin)
>  {
>  	int irq, i;
