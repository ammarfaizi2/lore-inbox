Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSETHpG>; Mon, 20 May 2002 03:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315808AbSETHpF>; Mon, 20 May 2002 03:45:05 -0400
Received: from mail.spylog.com ([194.67.35.220]:3493 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S315805AbSETHpD>;
	Mon, 20 May 2002 03:45:03 -0400
Date: Mon, 20 May 2002 11:44:57 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Peter Osterlund <petero2@telia.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>, hch@infradead.org
Subject: Re: I/O-APIC not enabled in 2.4.19-pre8 on UP machines
Message-ID: <20020520074457.GA18329@spylog.ru>
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel <linux-kernel@vger.kernel.org>, hch@infradead.org
In-Reply-To: <m2elg88k9g.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter Osterlund,


 Many thanks. The problem with AIC drivers has disappeared. An Intel appeared not
 and, L440GX AIC again works on one processor.  



Once you wrote about "I/O-APIC not enabled in 2.4.19-pre8 on UP machines":
> It looks like I/O-APIC setup was accidentally disabled in 2.4.19-pre7
> for UP machines.
> 
> Here is a patch to fix it:
> 
> --- linux/arch/i386/kernel/io_apic.c.orig	Sun May 19 12:58:40 2002
> +++ linux/arch/i386/kernel/io_apic.c	Sun May 19 12:58:24 2002
> @@ -191,11 +191,7 @@
>  #define MAX_PIRQS 8
>  int pirq_entries [MAX_PIRQS];
>  int pirqs_enabled;
> -#ifdef CONFIG_X86_UP_APIC
> -int skip_ioapic_setup=1;
> -#else
> -int skip_ioapic_setup=0;
> -#endif
> +int skip_ioapic_setup;
>  
>  static int __init noioapic_setup(char *str)
>  {
> 
> -- 
> Peter Osterlund - petero2@telia.com
> http://w1.894.telia.com/~u89404340
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bye.
Andrey Nekrasov, SpyLOG.
