Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbTIDM7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTIDM7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:59:32 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:35006 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264993AbTIDM7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:59:24 -0400
Date: Thu, 4 Sep 2003 14:57:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <16215.13051.836875.270440@nanango.paulus.ozlabs.org>
Message-ID: <Pine.GSO.4.21.0309041449260.8244-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Paul Mackerras wrote:
> Geert Uytterhoeven writes:
> > `ioremap is meant for PCI memory space only'
> 
> Did I say that, or someone else? :)  ioremap predates PCI support by a
> long way IIRC...

inb() and friends are for ISA/PCI I/O space
isa_readb() and friends are for ISA memory space
readb() and friends are for PCI memory space (after ioremap())

That's why other buses (e.g. SBUS and Zorro) have their own versions of
ioremap() and readb() etc.).

Life would be much easier with bus-specific I/O ops...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

