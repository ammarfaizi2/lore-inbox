Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQLRWoD>; Mon, 18 Dec 2000 17:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbQLRWnx>; Mon, 18 Dec 2000 17:43:53 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:62223 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129849AbQLRWnl>; Mon, 18 Dec 2000 17:43:41 -0500
Date: Mon, 18 Dec 2000 23:13:08 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E1488Mm-0006Hl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1001218231007.28629A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Imagine that kpiod is slow. try_to_swap_out returns 1 and pretends it
> > freed something but it didn't. It just passed request to kpiod. There are
> > no pages to be freed by shrink_mmap. do_try_to_swap_out calls swap_out
> > several times, then returns. And this repeats again and again.
> 
> kpiod ceased to exist as of 2.2.19pre2

BTW. why didn't you fix SMP race in accessing pte? It's several months old
and quite subtle bug.

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
