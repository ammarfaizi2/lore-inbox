Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBKU1M>; Sun, 11 Feb 2001 15:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129633AbRBKU1D>; Sun, 11 Feb 2001 15:27:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12558 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130078AbRBKU0w>; Sun, 11 Feb 2001 15:26:52 -0500
Subject: Re: [RFC] framework for fpu usage in kernel
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 11 Feb 2001 20:26:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, arjan@fenrus.demon.nl (Arjan van de Ven),
        dledford@redhat.com (Doug Ledford),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <3A86E21D.9AB66964@colorfullife.com> from "Manfred Spraul" at Feb 11, 2001 08:03:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S359-0004vi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> memcopy is a really generic function, and calling it saves the current
> fpu state into thread.i387.f{,x}save. IMHO that's wrong, memcopy must
> save into a local buffer like raid5 checksumming.

The mmx copy is only done in task context. There are a whole variety
of _horrible_ problems doing it in interrupt space so based on the 
considerable number of problems with prior attempts to get it right on
IRQ and copyuser cases I didnt bother
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
