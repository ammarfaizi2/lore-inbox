Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129095AbQJaPDH>; Tue, 31 Oct 2000 10:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbQJaPC5>; Tue, 31 Oct 2000 10:02:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20584 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129033AbQJaPCu>; Tue, 31 Oct 2000 10:02:50 -0500
Subject: Re: kmalloc() allocation.
To: kernel@kvack.org
Date: Tue, 31 Oct 2000 15:01:46 +0000 (GMT)
Cc: bgerst@didntduck.org (Brian Gerst), ak@suse.de (Andi Kleen),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1001031094639.27969B-100000@kanga.kvack.org> from "kernel@kvack.org" at Oct 31, 2000 09:48:04 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qcv6-0007yy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The code for vmalloc allocates the pages at vmalloc time, not after.  The
> TLB is populated lazily, but most definately not the page tables.

Is the lazy tlb population interrupt safe or do I need to change any driver
using vmalloced memory from an IRQ ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
