Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272698AbRHaOIj>; Fri, 31 Aug 2001 10:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272696AbRHaOI3>; Fri, 31 Aug 2001 10:08:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30473 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272698AbRHaOIS>; Fri, 31 Aug 2001 10:08:18 -0400
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
To: kraxel@bytesex.org (Gerd Knorr)
Date: Fri, 31 Aug 2001 15:12:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <slrn9ouep3.4d6.kraxel@bytesex.org> from "Gerd Knorr" at Aug 31, 2001 07:22:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cp1h-0003HE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What addresses are in dev->resource?  Physical?  Bus address?  Are they
> unique?

Basically its an arbitary cookie suitable only for passing to ioremap. In
practice its likely to be a bus address but not always since it may be a
combined ident (controller id<<lots|offset) or even a pointer to a struct
private to the platform

Currently I think everyone mainstrem except the pa-risc has either a bus
address or physical address in the registers. For pa the I/O port map used
to be (and might still be) a controller/offset pair.

Alan
