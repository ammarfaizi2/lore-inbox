Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWGaK5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWGaK5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWGaK5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:57:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30164 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751522AbWGaK5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:57:30 -0400
Subject: Re: [PATCH] ide support for VIA 8237a southbridge
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Diego Calleja <diegocg@gmail.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060730210923.9092774e.diegocg@gmail.com>
References: <20060730210923.9092774e.diegocg@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 12:16:16 +0100
Message-Id: <1154344576.7230.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-30 am 21:09 +0200, ysgrifennodd Diego Calleja:
> Alan Cox added (622b20fcb8b42aa4c3c87c0a036f2ad0927b64bc) some PCI IDs 
> for some VIA devices, including the 8237a. The driver, however, has not
> been changed to support the 8237a, and someone reported it through
> bugzilla (http://bugzilla.kernel.org/show_bug.cgi?id=6925)

The libata driver was, the change for the old driver was sent to the
maintainer on the same date. Ask Bartlomiej where it went.

> Signed-off-by: Diego Calleja <diegocg@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

> --- 2.6/drivers/ide/pci/via82cxxx.c.BUGGY	2006-07-30 20:55:18.000000000 +0200
> +++ 2.6/drivers/ide/pci/via82cxxx.c	2006-07-30 21:03:25.000000000 +0200
> @@ -6,7 +6,7 @@
>   *
>   *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
>   *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a,
> - *   vt8235, vt8237
> + *   vt8235, vt8237, vt8237a
>   *
>   * Copyright (c) 2000-2002 Vojtech Pavlik
>   *
> @@ -81,6 +81,7 @@ static struct via_isa_bridge {
>  	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
>  	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
>  	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
> +	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
>  	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
>  	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
>  	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
