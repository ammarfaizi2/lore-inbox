Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265952AbUBJQDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUBJQDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:03:21 -0500
Received: from witte.sonytel.be ([80.88.33.193]:25274 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265952AbUBJQDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:03:20 -0500
Date: Tue, 10 Feb 2004 17:03:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689362321@kroah.com>
Message-ID: <Pine.GSO.4.58.0402101702420.2261@waterleaf.sonytel.be>
References: <10763689362321@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, Greg KH wrote:
> ChangeSet 1.1500.11.2, 2004/01/30 16:34:48-08:00, ambx1@neo.rr.com
>
> [PATCH] PCI: Remove uneeded resource structures from pci_dev
>
> The following patch remove irq_resource and dma_resource from pci_dev.  It
> appears that the serial pci driver depends on irq_resource, however, it may be
> broken portions of an old quirk.  I attempted to maintain the existing behavior
> while removing irq_resource.  I changed FL_IRQRESOURCE to FL_NOIRQ.  Russell,
> could you provide any comments?  irq_resource and dma_resource are most likely
> remnants from when pci_dev was shared with pnp.

FYI, at least one ISDN driver seems to need it as well:

| drivers/isdn/hardware/avm/b1isa.c: In function `b1isa_init':
| drivers/isdn/hardware/avm/b1isa.c:183: structure has no member named `irq_resource'

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
