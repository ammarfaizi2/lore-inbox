Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUDHIuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 04:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264216AbUDHIuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 04:50:00 -0400
Received: from witte.sonytel.be ([80.88.33.193]:42165 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264211AbUDHIt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 04:49:57 -0400
Date: Thu, 8 Apr 2004 10:49:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] obsolete asm/hdreg.h [3/5]
In-Reply-To: <200404080023.04460.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.GSO.4.58.0404081048270.9729@waterleaf.sonytel.be>
References: <200404080023.04460.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> [IDE] asm/ide.h: ide_ioreg_t cleanup
>
> ide_ioreg_t is deprecated and hasn't been used by IDE driver for some time.
> Use unsigned long directly on alpha, arm26, arm, mips, parisc, ppc64 and sh.
>
> asm-ia64/ide.h (ide_ioreg_t is unsigned short) and asm-m68knommu/ide.h
> (broken - ide_ioreg_t is not defined) are the only users of ide_ioreg_t left.

Why do you consider asm-m68knommu/ide.h broken?

It just includes <asm-m68k/hdreg.h>, which is definitely not broken since it's
happily (albeit very slowly) running apt-get upgrade right now ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
