Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131992AbQLZUYR>; Tue, 26 Dec 2000 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132009AbQLZUYH>; Tue, 26 Dec 2000 15:24:07 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:8718 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131992AbQLZUYB>; Tue, 26 Dec 2000 15:24:01 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200012261952.TAA11390@mauve.demon.co.uk>
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
To: riel@conectiva.com.br (Rik van Riel)
Date: Tue, 26 Dec 2000 19:52:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012261434110.16178-100000@duckman.distro.conectiva> from "Rik van Riel" at Dec 26, 2000 02:35:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 26 Dec 2000, Felix von Leitner wrote:
> > Thus spake Rik van Riel (riel@conectiva.com.br):
> > > > One more detail: top says the CPU is 50% system when reading from either
> > > > one of the disk or raid devices.  That seems awfully high considering
> > > > that the Promise controller claims to do UDMA.
> > > > 
> > > > Any comments?
> > > Your program reads in data at 30MB/second, on a memory bus
> > > that most likely supports something like 60 to 100MB/second.
> > 
> > 100.
> 
> So that's 30% for the UDMA controller and maybe
> 30% for the CPU (if your program reads in all the
> data).

Where are you getting 100MB/s?
The PCI bus can move around 130MB/sec, but RAM is lots faster.
A single PC100 DIMM can move 800MB/sec.
This P100 laptop I'm typing on gets better than 100MB/s ram reads.


Anyway, in clarification, Rik mentioned that two reads from different
disk (arrays?) on the same controller at the same time get more or less
the same speed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
