Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290594AbSBNHLg>; Thu, 14 Feb 2002 02:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290794AbSBNHL0>; Thu, 14 Feb 2002 02:11:26 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:27777 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290594AbSBNHLO>; Thu, 14 Feb 2002 02:11:14 -0500
Message-Id: <200202140653.g1E6rHoL005371@tigger.cs.uni-dortmund.de>
To: James Simmons <jsimmons@transvirtual.com>
cc: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        davej@suse.de, Roman Zippel <zippel@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers 
In-Reply-To: Message from James Simmons <jsimmons@transvirtual.com> 
   of "Wed, 13 Feb 2002 11:25:23 PST." <Pine.LNX.4.10.10202131123230.2524-100000@www.transvirtual.com> 
Date: Thu, 14 Feb 2002 07:53:16 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@transvirtual.com> said:

[...]

> Done. Here is another patch. 
> 
> diff -urN -X /home/jsimmons/dontdiff linux-2.5.4-dj1/arch/m68k/amiga/config.c l
> inux/arch/m68k/amiga/config.c
> --- linux-2.5.4-dj1/arch/m68k/amiga/config.c	Wed Jan 16 10:31:50 2002
> +++ linux/arch/m68k/amiga/config.c	Wed Feb 13 10:26:42 2002
> @@ -69,11 +69,13 @@
>  extern char m68k_debug_device[];
>  
>  static void amiga_sched_init(void (*handler)(int, void *, struct pt_regs *));
> +#ifndef CONFIG_KEYBOARD_AMIGA
>  /* amiga specific keyboard functions */
>  extern int amiga_keyb_init(void);
>  extern int amiga_kbdrate (struct kbd_repeat *);
>  extern int amiga_kbd_translate(unsigned char keycode, unsigned char *keycodep,
>  			       char raw_mode);
> +#endif

The #ifdef isn't needed: As long as the functions aren't used, gcc won't
mind them declared if they aren't around.

[...]

> --- linux-2.5.4-dj1/arch/ppc/amiga/config.c	Wed Jan 16 10:31:50 2002
> +++ linux/arch/ppc/amiga/config.c	Wed Feb 13 10:26:42 2002
> @@ -77,9 +77,11 @@
>  extern char m68k_debug_device[];
>  
>  static void amiga_sched_init(void (*handler)(int, void *, struct pt_regs *));
> +#ifndef CONFIG_KEYBOARD_AMIGA
>  /* amiga specific keyboard functions */
>  extern int amiga_keyb_init(void);
>  extern int amiga_kbdrate (struct kbd_repeat *);
> +#endif

As above.
-- 
Horst von Brand			     http://counter.li.org # 22616
