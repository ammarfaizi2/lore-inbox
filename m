Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136339AbRAGSla>; Sun, 7 Jan 2001 13:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136410AbRAGSlV>; Sun, 7 Jan 2001 13:41:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10512 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136339AbRAGSlI>; Sun, 7 Jan 2001 13:41:08 -0500
Subject: Re: [PATCH] hisax/sportster dependency error
To: kai@thphy.uni-duesseldorf.de (Kai Germaschewski)
Date: Sun, 7 Jan 2001 18:42:13 +0000 (GMT)
Cc: stodden@in.tum.de (Daniel Stodden), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101060338180.13176-100000@vaio> from "Kai Germaschewski" at Jan 07, 2001 12:11:21 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FKlk-00037v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > according to sportster.c:get_io_range, this appears to be perfectly
> > intentional, request_regioning 64x8 byte from 0x268 in 1024byte-steps.
> 
> AFAIK, this is because the hardware is stupid and does decode the higher
> address lines. Therefore, the IO ports are mirrored every 1024 bytes and
> should be reserved to avoid potential conflicts with other devices.

Almost every 10bit decode ISA card is like that. You don't need to do the
work. The PCI alloc rules already cover it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
