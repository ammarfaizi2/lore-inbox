Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbRABSOv>; Tue, 2 Jan 2001 13:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRABSOl>; Tue, 2 Jan 2001 13:14:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6931 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129325AbRABSO3>; Tue, 2 Jan 2001 13:14:29 -0500
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h
To: ak@suse.de (Andi Kleen)
Date: Tue, 2 Jan 2001 17:18:52 +0000 (GMT)
Cc: matthew@wil.cx (Matthew Wilcox), davem@redhat.com (David S. Miller),
        grundler@cup.hp.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, parisc-linux@thepuffingroup.com
In-Reply-To: <20010102125924.A9538@gruyere.muc.suse.de> from "Andi Kleen" at Jan 02, 2001 12:59:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DV5K-0002Xn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We really can't.  We _only_ have load-and-zero.  And it has to be 16-byte
> > aligned.  xchg() is just not something the CPU implements.
> 
> The network code relies on the reader-xchg semantics David described in 
> several places.

I guess the network code will just have to change for 2.5. read_xchg_val()
can be a null macro for everyone else at least

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
