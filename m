Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278769AbRJZRaU>; Fri, 26 Oct 2001 13:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278771AbRJZRaK>; Fri, 26 Oct 2001 13:30:10 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:2824 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S278769AbRJZR34>; Fri, 26 Oct 2001 13:29:56 -0400
Message-ID: <3BD99DB1.7B09DDBE@linux-m68k.org>
Date: Fri, 26 Oct 2001 19:30:25 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
CC: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strtok --> strsep in framebuffer drivers
In-Reply-To: <m15vJFv-007qbrC@smtp.web.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> diff -ur linux-2.4.13-pre5/drivers/video/virgefb.c
> linux-2.4.13-pre5-rs/drivers/video/virgefb.c
> --- linux-2.4.13-pre5/drivers/video/virgefb.c   Fri Sep 14 01:04:43 2001
> +++ linux-2.4.13-pre5-rs/drivers/video/virgefb.c        Sun Oct 21 13:02:11 2001
> @@ -1085,7 +1085,7 @@
>         if (!options || !*options)
>                 return 0;
> 
> -       for (this_opt = strtok(options, ","); this_opt; this_opt = strtok(NULL,
> ","))
> +       while (this_opt = strsep(&options, ",")) {
>                 if (!strcmp(this_opt, "inverse")) {
>                         Cyberfb_inverse = 1;
>                         fb_invert_cmaps();

You add a left brace here.

bye, Roman
