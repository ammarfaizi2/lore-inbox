Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287899AbSAMBSt>; Sat, 12 Jan 2002 20:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287907AbSAMBSk>; Sat, 12 Jan 2002 20:18:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11780 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287899AbSAMBSb>; Sat, 12 Jan 2002 20:18:31 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: ken@canit.se (Kenneth Johansson)
Date: Sun, 13 Jan 2002 01:30:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        arjan@fenrus.demon.nl, landley@trommello.org (Rob Landley),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C409E3C.A4968CE@canit.se> from "Kenneth Johansson" at Jan 12, 2002 09:36:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZTI-0003ge-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I must have missed that in the code. I can see you check __cli() status but
> > I didn't see anywhere you check disable_irq(). Even if you did it doesnt
> > help when I mask the irq on the chip rather than using disable_irq() calls.
> 
> But you get interrupted by other interrups then so you have the same problem
> reagardless of any preemtion patch you hopefully lose the cpu for a much
> shorter time but still the same problem.

Interrupt paths are well sub millisecond, a pre empt might mean I don't get
the CPU back for measurable chunks of a second.  They are totally different
guarantees. 
