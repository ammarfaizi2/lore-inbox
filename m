Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286935AbSAFCKR>; Sat, 5 Jan 2002 21:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbSAFCKI>; Sat, 5 Jan 2002 21:10:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286935AbSAFCJy>; Sat, 5 Jan 2002 21:09:54 -0500
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sun, 6 Jan 2002 02:20:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mingo@elte.hu (Ingo Molnar),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.40.0201051812080.1607-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Jan 05, 2002 06:12:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16N2vX-00023B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > then it represents a huge win since an 8bit ffz can be done by lookup table
> > and that is fast on all processors
> 
> It's here that i want to go, but i'd liketo do it gradually :)
> unsigned char first_bit[255];

Make it [256] and you can do 9 queues since the idle task will always
be queued...
