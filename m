Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUCIMUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 07:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUCIMUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 07:20:09 -0500
Received: from witte.sonytel.be ([80.88.33.193]:50146 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261898AbUCIMT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 07:19:58 -0500
Date: Tue, 9 Mar 2004 13:19:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Eger <eger@havoc.gtf.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] UTF-8ifying the kernel source
In-Reply-To: <20040305232425.GA6239@havoc.gtf.org>
Message-ID: <Pine.GSO.4.58.0403091152080.26626@waterleaf.sonytel.be>
References: <20040304100503.GA13970@havoc.gtf.org> <20040305232425.GA6239@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004, David Eger wrote:
> Un-needed/wrong non-ASCII characters (patch 2)
> ==============================================
> drivers/video/amifb.c	- +- sign (NOTE: X's .ttf files just don't have it)

do_blank is either 0 (do nothing), -1 (unblank), or +1 (blank).

You can replace it by `+/-1' if you want.

> include/asm-m68k/atarihw.h	- 0x94? no, it's an ö, for Björn
> include/asm-m68k/atariints.h	- 0x94? no, it's an ö, for Björn

Yep.

> Machine / charset specific shite - (does anything need to be done?)
> ===================================================================
> arch/m68k/hp300/hp300map.map	- maps to "char"s.. grr
> drivers/char/defkeymap.map	- a map file... maps to "char"s.. grr
> drivers/char/qtronixmap.c_shipped	- maps to "char"s.. grr
> drivers/char/qtronixmap.map	- maps to "char"s.. grr
> drivers/tc/lk201-map.c_shipped	- maps to "char"s.. grr
> drivers/tc/lk201-map.map	- maps to "char"s.. grr
> drivers/acorn/char/defkeymap-l7200.c	- maps to "char"s.. grr

If you want the keyboard to generate UTF-8, I think you should change these
(not sure, please test).

> drivers/video/console/font_8x16.c	- comments on a keymap table
> drivers/video/console/font_8x8.c	- comments on a keymap table
> drivers/video/console/font_pearl_8x8.c	- comments on a keymap table

These fonts have the box-drawing ASCII art.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
