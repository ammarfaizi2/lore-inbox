Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269913AbTGKMX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269914AbTGKMX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:23:28 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:21677 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269913AbTGKMX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:23:27 -0400
Date: Fri, 11 Jul 2003 14:30:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Mosberger <davidm@napali.hpl.hp.com>,
       Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: incbin (was: Re: Linux 2.5.75)
In-Reply-To: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
Message-ID: <Pine.GSO.4.21.0307111425371.8989-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, Linus Torvalds wrote:
> David Mosberger:
>   o Use ".incbin" for initramfs image build

Why was this change necessary? It requires me to build a new toolchain (yes I
know Documentation/Changes says you need at least 2.12):

| tux$ make usr/
|   AS      usr/initramfs_data.o
| usr/initramfs_data.S: Assembler messages:
| usr/initramfs_data.S:2: Error: Unknown pseudo-op:  `.incbin'
| make[1]: *** [usr/initramfs_data.o] Error 1
| make: *** [usr/] Error 2
| tux$ m68k-linux-ld -v
| GNU ld version 2.9.5 (with BFD 2.9.5.0.37)
| tux$ 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

