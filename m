Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTBEOZd>; Wed, 5 Feb 2003 09:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbTBEOZd>; Wed, 5 Feb 2003 09:25:33 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:34553 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261371AbTBEOZc>;
	Wed, 5 Feb 2003 09:25:32 -0500
Date: Wed, 5 Feb 2003 15:34:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: add framework for ndelay (nanoseconds)
In-Reply-To: <200302040533.h145Xqq19457@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0302051533320.16681-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.953.4.9, 2003/02/02 02:44:15-02:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] PATCH: add framework for ndelay (nanoseconds)
> 	
> +void __ndelay(unsigned long usecs)
                               ^^^^^
> +{
> +	__const_udelay(usecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
                       ^^^^^
> +}

Wouldn't it make more sense to call the parameter `nsecs' (or `ns')?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

