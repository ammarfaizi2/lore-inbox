Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUGLN0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUGLN0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUGLN0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:26:53 -0400
Received: from witte.sonytel.be ([80.88.33.193]:63157 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266825AbUGLN0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:26:00 -0400
Date: Mon, 12 Jul 2004 15:25:50 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc1
In-Reply-To: <87pt71jre2.fsf@devron.myhome.or.jp>
Message-ID: <Pine.GSO.4.58.0407121524420.17199@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
 <Pine.GSO.4.58.0407121356510.17199@waterleaf.sonytel.be>
 <87pt71jre2.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, OGAWA Hirofumi wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Sun, 11 Jul 2004, Linus Torvalds wrote:
> > > Hirofumi Ogawa:
> > >   o FAT: don't use "utf8" charset and NLS_DEFAULT
> >
> > This patch breaks compilation if both MSDOS_FS and VFAT_FS are not set, due to
> > CONFIG_FAT_DEFAULT_CODEPAGE being undefined.
> >
> > Suggested fix: either make FAT_DEFAULT_CODEPAGE depend on FAT_FS only
> > (compilation of fs/fat/inode.c depends on FAT_FS), or add a test for
> > CONFIG_FAT_DEFAULT_CODEPAGE being undefined, cfr. the test for
> > CONFIG_FAT_DEFAULT_IOCHARSET in fs/fat/inode.c.
>
> Why did you need only FAT_FS? If it was not needed, I'll remove the

It was a leftover in my current .config.

> configurable FAT_FS, instead it is internally used only.

If it's for internal use only, perhaps it should not be presented to the user
and both MSDOS_FS and VFAT_FS should simply select it in Kconfig?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
