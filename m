Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbQKSNWU>; Sun, 19 Nov 2000 08:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130370AbQKSNWL>; Sun, 19 Nov 2000 08:22:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30746 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129740AbQKSNVu>; Sun, 19 Nov 2000 08:21:50 -0500
Subject: Re: 7-order allocation failed
To: zinx@microsoftisevil.com (Forever shall I be.)
Date: Sun, 19 Nov 2000 12:52:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001119001750.A27537@bliss.zebra.net> from "Forever shall I be." at Nov 19, 2000 12:17:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xTx0-0002hb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm getting '__alloc_pages: 7-order allocation failed.' every time I
> play something to my maestro card (using the maestro kernel module,
> with dsps_order=2)..

Its a debugging message.

> for (order = (dsps_order + (16-PAGE_SHIFT) + 1); order >= (dsps_order + 2 + 1); order--)
>         if((rawbuf = (void *)__get_free_pages(GFP_KERNEL|GFP_DMA, order)))
>                 break;
> 
> Of course, it doesn't seem to cause any problems, but the warning is
> really starting to get on my nerves...

Order 6 succeeded in this case.

Ignore it
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
