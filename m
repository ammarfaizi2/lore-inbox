Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSAMB13>; Sat, 12 Jan 2002 20:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSAMB1T>; Sat, 12 Jan 2002 20:27:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20228 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284264AbSAMB1C>; Sat, 12 Jan 2002 20:27:02 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: rml@tech9.net (Robert Love)
Date: Sun, 13 Jan 2002 01:38:39 +0000 (GMT)
Cc: ken@canit.se (Kenneth Johansson), alan@lxorguk.ukuu.org.uk (Alan Cox),
        arjan@fenrus.demon.nl, landley@trommello.org (Rob Landley),
        linux-kernel@vger.kernel.org
In-Reply-To: <1010876470.3560.0.camel@phantasy> from "Robert Love" at Jan 12, 2002 06:01:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZbb-0003i6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > But you get interrupted by other interrups then so you have the same problem
> > reagardless of any preemtion patch you hopefully lose the cpu for a much
> > shorter time but still the same problem.
> 
> Agreed.  Further, you can't put _any_ upper bound on the number of
> interrupts that could occur, preempt or not.  Sure, preempt can make it
> worse, but I don't see it.  I have no bug reports to correlate.

How may full benchmark sets have you done on an NE2000. Its quite obvious
from your earlier mail you hadn't even considered problems like this.

Let me ask you the _right_ question instead

-	Prove to me that there are no cases that pre-empt doesn't screw up
	like this.
-	Prove to me that pre-empt is better than the big low latency patch

All I have seen so far is benchmarks that say low latency is better as is,
and evidence that preempt patches cause far more problems than they solve
and have complex and subtle side effects nobody yet understands.

Furthermore its obvious that the only way to fix these side effects is to
implement full priority handling to avoid priority inversion issues (which
is precisely what the IRQ problem is) , that means implementing interrupt
handlers as threads, heavyweight locks and an end result I'm really not
interested in using.

Alan
