Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286139AbRLJBnj>; Sun, 9 Dec 2001 20:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286132AbRLJBn3>; Sun, 9 Dec 2001 20:43:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286142AbRLJBnQ>; Sun, 9 Dec 2001 20:43:16 -0500
Subject: Re: [RFC] Scheduler queue implementation ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Mon, 10 Dec 2001 01:52:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.40.0112091729180.996-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 09, 2001 05:38:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DFcV-0000E0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> vmstat together with a lat_ctx 32 32 ... ( long list ), you'll see the run
> queue length barley reach 3 ( with 32 bouncing tasks ).
> It barely reaches 5 with 64 bouncing tasks.

Try 250 apache server processes running a mix of mod_perl and static
content, you'll see quite a reasonable queue size then, and it isnt all
cpu hogs.

Interesting question however. I certainly can't disprove your belief that
the queue will be short enough to be worth using multiqueue for the case
where its a queue per processor.

Alan
