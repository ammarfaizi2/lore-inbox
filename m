Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUGTUB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUGTUB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUGTUAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:00:15 -0400
Received: from witte.sonytel.be ([80.88.33.193]:22229 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266209AbUGTT66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:58:58 -0400
Date: Tue, 20 Jul 2004 21:58:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] depends on PCI DMA API: Adaptec AIC7xxx_old
In-Reply-To: <1090353229.1947.7.camel@mulgrave>
Message-ID: <Pine.GSO.4.58.0407202155260.24931@waterleaf.sonytel.be>
References: <200407201839.i6KIdo2I015550@anakin.of.borg> <1090353229.1947.7.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004, James Bottomley wrote:
> On Tue, 2004-07-20 at 13:39, Geert Uytterhoeven wrote:
> > Adaptec AIC7xxx_old unconditionally depends on the PCI DMA API, so mark it
> > broken if !PCI
>
> Are you sure this is valid?  I thought it used a NULL pci device for
> EISA (which I hate, but which still apparently works at least on x86).

Wel, I guess we can discuss about that :-)

It uses pci_alloc_consistent() and friends, which are not necessarily defined
if !PCI. A better solution may be to convert the driver to use the generic DMA
API instead of the PCI DMA API when PCI is not selected.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
