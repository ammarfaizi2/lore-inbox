Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbTAJMaf>; Fri, 10 Jan 2003 07:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbTAJMaf>; Fri, 10 Jan 2003 07:30:35 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:33751 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264972AbTAJMae>;
	Fri, 10 Jan 2003 07:30:34 -0500
Date: Fri, 10 Jan 2003 13:38:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: __gpl_ksymtab 
In-Reply-To: <20030110091014.231C82C4C2@lists.samba.org>
Message-ID: <Pine.GSO.4.21.0301101338110.9440-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Rusty Russell wrote:
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/m68k/vmlinux-std.lds working-2.5.55-gpl_ksymtab/arch/m68k/vmlinux-std.lds
> --- linux-2.5.55/arch/m68k/vmlinux-std.lds	2003-01-02 14:47:57.000000000 +1100
> +++ working-2.5.55-gpl_ksymtab/arch/m68k/vmlinux-std.lds	2003-01-10 19:43:03.000000000 +1100
> @@ -24,6 +24,10 @@ SECTIONS
>    __ksymtab : { *(__ksymtab) }
>    __stop___ksymtab = .;
>  
> +  __start___ksymtab = .;	/* Kernel symbol table */
> +  __ksymtab : { *(__ksymtab) }
> +  __stop___ksymtab = .;

Woops, where's the `gpl'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

