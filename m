Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131044AbQKPS3m>; Thu, 16 Nov 2000 13:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131166AbQKPS3c>; Thu, 16 Nov 2000 13:29:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44351 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131044AbQKPS3R>; Thu, 16 Nov 2000 13:29:17 -0500
Subject: Re: PATCH: 8139too kernel thread
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 16 Nov 2000 17:59:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, netdev@oss.sgi.com
In-Reply-To: <200011102129.QAA13369@havoc.gtf.org> from "Jeff Garzik" at Nov 10, 2000 04:29:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wTKL-000899-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only disadvantage to this scheme is the added cost of a kernel
> thread over a kernel timer.  I think this is an ok cost, because this
> is a low-impact thread that sleeps a lot..

8K of memory, two tlb flushes, cache misses on the scheduler. The price is
actually extremely high.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
