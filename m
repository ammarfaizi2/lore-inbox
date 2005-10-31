Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVJaVGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVJaVGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVJaVGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:06:05 -0500
Received: from witte.sonytel.be ([80.88.33.193]:29136 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964836AbVJaVFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:05:50 -0500
Date: Mon, 31 Oct 2005 22:05:15 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
In-Reply-To: <14.196662837@selenic.com>
Message-ID: <Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be>
References: <14.196662837@selenic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Matt Mackall wrote:
> inflate: remove legacy type definitions from callers
> 
> This replaces the legacy zlib typedefs and usage with kernel types in
> all the inflate users.

> -static ulg free_mem_ptr;
> -static ulg free_mem_ptr_end;
> +static u32 free_mem_ptr;
> +static u32 free_mem_ptr_end;

Bang, on 64-bit platforms...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
