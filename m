Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVDSTQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVDSTQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVDSTQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:16:38 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24962 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261612AbVDSTQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:16:10 -0400
Date: Tue, 19 Apr 2005 21:15:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] introduce generic 64bit rotations and i386 asm optimized
 version
In-Reply-To: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.62.0504192114240.14178@jaguar.sonytel.be>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Denis Vlasenko wrote:

[ Please inline patches, so it's easier to comment on them ]

> +static inline u64 rol64(u64 x,int num) {
                                     ^^^
> +	if(__builtin_constant_p(num))
> +		return constant_rol64(x,num);
> +	/* Hmmm... shall we do cnt&=63 here? */
                               ^^^
			       num?

> +	return ((x<<num) | (x>>(64-num)));
> +}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
