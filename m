Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSAMPd4>; Sun, 13 Jan 2002 10:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbSAMPdq>; Sun, 13 Jan 2002 10:33:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38407 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286161AbSAMPdj>; Sun, 13 Jan 2002 10:33:39 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Sun, 13 Jan 2002 15:45:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        ken@canit.se (Kenneth Johansson), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <3C41A545.A903F24C@linux-m68k.org> from "Roman Zippel" at Jan 13, 2002 04:18:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Pmok-0007GD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What somehow got lost in this discussion, that both patches don't
> necessarily conflict with each other, they both attack the same problem
> with different approaches, which complement each other. I prefer to get
> the best of both patches.

When you look at the benchmark there is no difference between ll and 
ll+pre-empt. ll alone takes you to the 1ms point. pre-empt takes you no
further and to get much out of pre-emption requires you go and do all the
hideously slow and complex priority inversion stuff.

> exactly that reason. I don't think we need to work around broken
> hardware, but halfway decent hardware should not be a problem to get
> decent latency.

We have to work around common hardware not designed for SMP - the 8390 isnt
a broken chip in that sense, its just from a different era, and there are a 
lot of them.

