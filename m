Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKDSUv>; Sat, 4 Nov 2000 13:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDSUc>; Sat, 4 Nov 2000 13:20:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58146 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129044AbQKDSU3>; Sat, 4 Nov 2000 13:20:29 -0500
Subject: Re: Multithreaded locks.c
To: andrewm@uow.edu.au (Andrew Morton)
Date: Sat, 4 Nov 2000 18:20:19 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro),
        trond.myklebust@fys.uio.no (Trond Myklebust),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3A042031.A170B555@uow.edu.au> from "Andrew Morton" at Nov 05, 2000 01:41:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13s7vQ-0004hr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> have got it right.  Does anyone know what this part of the
> flock(2) manpage means?
> 
>        A  single file may not simultaneously have both shared and
>        exclusive locks.

AFAIK its saying LOCK_EX is exclusive and blocks shared locks and vice
versa.  Its a standard reader-writer lock setup. LOCK_EX is writer, LOCK_SH
is reader.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
