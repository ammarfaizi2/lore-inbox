Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290792AbSBTBqS>; Tue, 19 Feb 2002 20:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290790AbSBTBqI>; Tue, 19 Feb 2002 20:46:08 -0500
Received: from toole.uol.com.br ([200.231.206.186]:10719 "EHLO
	toole.uol.com.br") by vger.kernel.org with ESMTP id <S290792AbSBTBqA>;
	Tue, 19 Feb 2002 20:46:00 -0500
Date: Tue, 19 Feb 2002 22:45:54 -0300 (BRT)
From: Jean Paul Sartre <sartre@linuxbr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
In-Reply-To: <E16dLud-0002Bk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0202192244430.13176-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Alan Cox wrote:

> > 'shares' code with the fb code. What if I have SIS framebuffer disabled
> > and SIS DRM code enabled? In 2.4.18-rc2, the SIS DRM code does not compile
> > from the lack of sis_malloc and sis_free function.
>
> SIS DRM requires the SIS frame buffer.

	These are the compiling errors in make bzImage:

drivers/char/drm/drm.o: In function `sis_fb_alloc':
drivers/char/drm/drm.o(.text+0x451c6): undefined reference to `sis_malloc'
drivers/char/drm/drm.o(.text+0x4520d): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_fb_free':
drivers/char/drm/drm.o(.text+0x45352): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_final_context':
drivers/char/drm/drm.o(.text+0x45806): undefined reference to `sis_free'
make: *** [vmlinux] Error 1

	(so, DRM code does not take sis_malloc nor sis_free functions from
the FB code, that I expected to see)

	[]s,
	Cesar Suga <sartre@linuxbr.com>


