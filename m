Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTHYQOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbTHYQOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:14:23 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:13454 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261969AbTHYQOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:14:22 -0400
Date: Mon, 25 Aug 2003 18:13:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
In-Reply-To: <20030822204903.GA847@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.GSO.4.21.0308251810010.15307-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Tom Rini wrote:
> --- 1.18/drivers/video/console/Kconfig	Wed Jul 16 10:39:32 2003
> +++ edited/drivers/video/console/Kconfig	Fri Aug 22 13:27:21 2003
> @@ -5,7 +5,7 @@
>  menu "Console display driver support"
>  
>  config VGA_CONSOLE
> -	bool "VGA text console" if EMBEDDED || !X86
> +	bool "VGA text console" if STANDARD && X86
>  	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
>  	default y
>  	help

Ugh, this makes VGA_CONSOLE default to yes if X86 is not set, right? Don't you
want

    bool "VGA text console" if !STANDARD || X86

?

Or do I need an update course on Kconfig syntax?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

