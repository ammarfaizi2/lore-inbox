Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315350AbSEBSqn>; Thu, 2 May 2002 14:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315354AbSEBSqm>; Thu, 2 May 2002 14:46:42 -0400
Received: from mail.sonytel.be ([193.74.243.200]:60380 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S315350AbSEBSqj>;
	Thu, 2 May 2002 14:46:39 -0400
Date: Thu, 2 May 2002 20:46:11 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: martin@dalecki.de, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ide broken again
In-Reply-To: <Pine.LNX.4.21.0204300143240.23113-100000@serv>
Message-ID: <Pine.GSO.4.21.0205022039100.27986-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002, Roman Zippel wrote:
> 2. Why was ide_request_region removed? I see the changelog entry, but I
> somehow doubt you contacted any of the affected architectures or even
> really tested it. request_region will fail on most archs without ioports
> and no "hack" will change that.

Perhaps he noticed that on our beloved but marginally m68k we have dummy
ide_request_region() and friends (except on Q40, where IDE is faked to be in
I/O space) and do our resource management in the low-level driver (cfr. the
call to request_mem_region() in gayle.c)?

But then he still breaks PPC...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

