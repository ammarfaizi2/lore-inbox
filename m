Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129633AbRBKUad>; Sun, 11 Feb 2001 15:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130148AbRBKUaW>; Sun, 11 Feb 2001 15:30:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15374 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129633AbRBKUaG>; Sun, 11 Feb 2001 15:30:06 -0500
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
To: tao@acc.umu.se (David Weinehall)
Date: Sun, 11 Feb 2001 20:30:30 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox), nicku@vtc.edu.hk (Nick Urbanik),
        linux-kernel@vger.kernel.org (Kernel list)
In-Reply-To: <20010211210826.D20267@khan.acc.umu.se> from "David Weinehall" at Feb 11, 2001 09:08:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S38k-0004wM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Would it be costly/reasonable to have kmalloc -not- panic if given a
> > too-large size?  Principle of Least Surprises says it should return NULL
> > at the very least.
> 
> It's on purpose; to find the erroneous drivers.

Unfortunately Linus forgot to provide a way to check if a kmalloc is too
large so the drivers cannot work around it. Dave put an incredibly ugly
constant assumption in af_unix for this and no doubt more will follow.

So -ac added the constant

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
