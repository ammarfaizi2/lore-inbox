Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287002AbSAFCX1>; Sat, 5 Jan 2002 21:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287119AbSAFCXS>; Sat, 5 Jan 2002 21:23:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287002AbSAFCXI>; Sat, 5 Jan 2002 21:23:08 -0500
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
To: mingo@elte.hu
Date: Sun, 6 Jan 2002 02:30:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        davidel@xmailserver.org (Davide Libenzi),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.33.0201060501560.5193-100000@localhost.localdomain> from "Ingo Molnar" at Jan 06, 2002 05:07:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16N35L-00024p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> we can do 32-bit ffz by doing 4x 8-bit ffz's though:

There are better algorithms than the branching one already. You can
do it a 32bit one with a multiply shift and 6 bit lookup if your multiply
is ok, or for non superscalar processors using shift and adds. 

64bit is 32bit ffz(x.low|x.high) and a single bit test

I can dig out the 32bit one if need be (its from a NetBSD mailing list)
