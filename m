Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129883AbRBLPAV>; Mon, 12 Feb 2001 10:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRBLPAP>; Mon, 12 Feb 2001 10:00:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25874 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130085AbRBLO75>; Mon, 12 Feb 2001 09:59:57 -0500
Subject: Re: sysinfo.sharedram not accounted for on i386 ?
To: tigran@veritas.com (Tigran Aivazian)
Date: Mon, 12 Feb 2001 15:00:15 +0000 (GMT)
Cc: brian@SoftHome.net (Brian Grossman), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102121239560.745-100000@penguin.homenet> from "Tigran Aivazian" at Feb 12, 2001 12:46:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SKSg-0007Cq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > like an awkward approach.  A related question: is the page size stored in
> > /proc somewhere?
> 
> No, PAGE_SIZE is known at compile time and cannot ever change (especially
> it cannot change ig you stay within i386 architecture). It is available to
> programs by including <asm/page.h> header.

Untrue. On many architectures page size is not fixed. You should use the
getpagesize() function/syscall. glibc knows if its a syscall or a constant
you dont

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
