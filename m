Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291874AbSBNU3z>; Thu, 14 Feb 2002 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291878AbSBNU3p>; Thu, 14 Feb 2002 15:29:45 -0500
Received: from www.transvirtual.com ([206.14.214.140]:5636 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291874AbSBNU3h>; Thu, 14 Feb 2002 15:29:37 -0500
Date: Thu, 14 Feb 2002 12:29:19 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        davej@suse.de, Roman Zippel <zippel@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers 
In-Reply-To: <200202140653.g1E6rHoL005371@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.4.10.10202141226230.19157-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > diff -urN -X /home/jsimmons/dontdiff linux-2.5.4-dj1/arch/m68k/amiga/config.c l
> > inux/arch/m68k/amiga/config.c
> > --- linux-2.5.4-dj1/arch/m68k/amiga/config.c	Wed Jan 16 10:31:50 2002
> > +++ linux/arch/m68k/amiga/config.c	Wed Feb 13 10:26:42 2002
> > @@ -69,11 +69,13 @@
> >  extern char m68k_debug_device[];
> >  
> >  static void amiga_sched_init(void (*handler)(int, void *, struct pt_regs *));
> > +#ifndef CONFIG_KEYBOARD_AMIGA
> >  /* amiga specific keyboard functions */
> >  extern int amiga_keyb_init(void);
> >  extern int amiga_kbdrate (struct kbd_repeat *);
> >  extern int amiga_kbd_translate(unsigned char keycode, unsigned char *keycodep,
> >  			       char raw_mode);
> > +#endif
> 
> The #ifdef isn't needed: As long as the functions aren't used, gcc won't
> mind them declared if they aren't around.

Personally I like to see all the mach_kbd* etc go away. 

