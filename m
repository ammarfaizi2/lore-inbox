Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264945AbTIDMXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264947AbTIDMXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:23:50 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:22676 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264945AbTIDMXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:23:48 -0400
Date: Thu, 4 Sep 2003 14:21:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <16215.7181.755868.593534@nanango.paulus.ozlabs.org>
Message-ID: <Pine.GSO.4.21.0309041420460.8244-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Paul Mackerras wrote:
> > Paul, what does actually use this higher addresses?
> 
> We have drivers for on-chip peripherals that work from a struct
> ocp_device and call ioremap on the ocp_dev->paddr value, which is a
> phys_addr_t (although some of them use __ioremap instead).  These
> drivers are used on 405-based systems (with 32-bit phys_addr_t) as
> well as on 440-based systems.
> 
> These drivers are in the linuxppc-2.{4,5} trees but most of them
> haven't made it into the official trees yet.  They could all be
> audited and converted to use __ioremap, although it seems a bit
> arbitrary to say that you can't use ioremap in a an ocp driver if
> you're going to use it on a 440.  I wouldn't expect it to be

`ioremap is meant for PCI memory space only'

Oops...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

