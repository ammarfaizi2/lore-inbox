Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269920AbTGKMZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269917AbTGKMZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:25:30 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:38830 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269919AbTGKMZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:25:21 -0400
Date: Fri, 11 Jul 2003 14:32:23 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Mosberger <davidm@napali.hpl.hp.com>,
       Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: incbin (was: Re: Linux 2.5.75)
In-Reply-To: <Pine.GSO.4.21.0307111425371.8989-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.4.21.0307111431350.8989-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Geert Uytterhoeven wrote:
> On Thu, 10 Jul 2003, Linus Torvalds wrote:
> > David Mosberger:
> >   o Use ".incbin" for initramfs image build
> 
> Why was this change necessary? It requires me to build a new toolchain (yes I
> know Documentation/Changes says you need at least 2.12):
> 
> | tux$ make usr/
> |   AS      usr/initramfs_data.o
> | usr/initramfs_data.S: Assembler messages:
> | usr/initramfs_data.S:2: Error: Unknown pseudo-op:  `.incbin'
> | make[1]: *** [usr/initramfs_data.o] Error 1
> | make: *** [usr/] Error 2
> | tux$ m68k-linux-ld -v
> | GNU ld version 2.9.5 (with BFD 2.9.5.0.37)
> | tux$ 

Oops, I missed this:

On Wed, 9 Jul 2003, David Mosberger wrote:
> As I recall, the only objection to this patch came from Russell King,
> since it would force ARM to upgrade to a reasonably recent version of
> binutils, but he (grudingly) agreed to the change.

So yes, m68k is affected too...

Gr{oetje,eeting}s,

						Geert, happily using gcc 2.95.2

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

