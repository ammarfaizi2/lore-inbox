Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131871AbRAGNgF>; Sun, 7 Jan 2001 08:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131955AbRAGNf4>; Sun, 7 Jan 2001 08:35:56 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35086 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131871AbRAGNfg>; Sun, 7 Jan 2001 08:35:36 -0500
Subject: Re: [PATCH] mptctl.c memory leak on failure
To: acme@conectiva.com.br (Arnaldo Carvalho de Melo)
Date: Sun, 7 Jan 2001 13:37:15 +0000 (GMT)
Cc: Steve.Ralston@lsil.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010107011226.C8362@conectiva.com.br> from "Arnaldo Carvalho de Melo" at Jan 07, 2001 01:12:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FG0b-0002dZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kmalloc and the comment: the buffer is used for DMA but the kmalloc doesn't
> has GFP_DMA, maybe I'm missing something here, its about time for me to

It should be kmalloc (or 2.4 wise pci_alloc_* I guess eventually). Its driven
by 32bit busmaster DMA. Its non ISA so it doesnt need GFP_DMA
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
