Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130251AbRBKUom>; Sun, 11 Feb 2001 15:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130285AbRBKUoc>; Sun, 11 Feb 2001 15:44:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27406 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130251AbRBKUoN>; Sun, 11 Feb 2001 15:44:13 -0500
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 11 Feb 2001 20:42:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), tao@acc.umu.se (David Weinehall),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        nicku@vtc.edu.hk (Nick Urbanik),
        linux-kernel@vger.kernel.org (Kernel list)
In-Reply-To: <3A86F86E.524778E2@colorfullife.com> from "Manfred Spraul" at Feb 11, 2001 09:39:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S3KC-0004yo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you really prefer if drivers contain a 
> 
> static inline void* safe_kmalloc(size, flags)
> {
> 	if(size > LIMIT)
> 		return NULL;
> 	return kmalloc(size, flags);
> }

It isnt that simple. Look at af_unix.c for example. It needs to know the
maximum safe request size to set values up and is prepared to accept
smaller values if that fails

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
