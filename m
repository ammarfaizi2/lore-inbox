Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136132AbRECG4y>; Thu, 3 May 2001 02:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136134AbRECG4o>; Thu, 3 May 2001 02:56:44 -0400
Received: from hood.tvd.be ([195.162.196.21]:7516 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S136132AbRECG4g>;
	Thu, 3 May 2001 02:56:36 -0400
Date: Thu, 3 May 2001 08:55:20 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: unsigned long ioremap()?
Message-ID: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Since you're not allowed to use direct memory dereferencing on ioremapped
areas, wouldn't it be more logical to let ioremap() return an unsigned long
instead of a void *?

Of course we then have to change readb() and friends to take a long as well,
but at least we'd get compiler warnings when someone tries to do a direct
dereference.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

