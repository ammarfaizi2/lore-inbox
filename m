Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316436AbSETXZj>; Mon, 20 May 2002 19:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSETXZi>; Mon, 20 May 2002 19:25:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21256 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316436AbSETXZh>; Mon, 20 May 2002 19:25:37 -0400
Date: Mon, 20 May 2002 19:27:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Peter Osterlund <petero2@telia.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, hch@infradead.org
Subject: Re: I/O-APIC not enabled in 2.4.19-pre8 on UP machines
In-Reply-To: <m2elg88k9g.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.21.0205201926570.1541-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its already applied in my tree.

Thanks

On 19 May 2002, Peter Osterlund wrote:

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

