Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286935AbRL1R13>; Fri, 28 Dec 2001 12:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284139AbRL1R1S>; Fri, 28 Dec 2001 12:27:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3850 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284138AbRL1R1I>; Fri, 28 Dec 2001 12:27:08 -0500
Subject: Re: 2.4.17 absurd number of context switches
To: davidel@xmailserver.org (Davide Libenzi)
Date: Fri, 28 Dec 2001 17:37:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jwb@saturn5.com (Jeffrey W. Baker),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0112280907060.1466-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 28, 2001 09:07:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K0wH-0001AG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The scheduler is _good_ at the three process case. Run some straces it looks
> > more like postgres is doing wacky yield based locks.
> 
> The scheduler that Linus merged in 2.5.2-pre3 will solve the problem.

Looking at the postgres traces here it wont make any difference at all. Not
one iota. If I am reading it right I have processes each going
yield, yield, yield... so the kernel does just that (and indeed posix
semantics require that behaviour).

Alan
