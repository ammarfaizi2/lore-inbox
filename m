Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSAFCC5>; Sat, 5 Jan 2002 21:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286911AbSAFCCr>; Sat, 5 Jan 2002 21:02:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50448 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286895AbSAFCCi>; Sat, 5 Jan 2002 21:02:38 -0500
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sun, 6 Jan 2002 02:13:32 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (lkml),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.40.0201051753090.1607-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Jan 05, 2002 06:02:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16N2oW-00021c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ingo, you don't need that many queues, 32 are more than sufficent.
> If you look at the distribution you'll see that it matters ( for
> interactive feel ) only the very first ( top ) queues, while lower ones
> can very easily tollerate a FIFO pickup w/out bad feelings.

64 queues costs a tiny amount more than 32 queues. If you can get it down
to eight or nine queues with no actual cost (espcially for non realtime queues)
then it represents a huge win since an 8bit ffz can be done by lookup table
and that is fast on all processors
