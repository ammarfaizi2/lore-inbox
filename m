Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286122AbRLJAnE>; Sun, 9 Dec 2001 19:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286125AbRLJAmz>; Sun, 9 Dec 2001 19:42:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33299 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286122AbRLJAml>; Sun, 9 Dec 2001 19:42:41 -0500
Subject: Re: [RFC] Scheduler queue implementation ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Mon, 10 Dec 2001 00:52:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml), alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.40.0112091558190.996-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 09, 2001 04:33:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DEfs-0008UJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So we can have simply two queues ( per CPU ), one that stores I/O bound (
> counter > K for example ) and RT tasks that is walked entirely searching
> for the better tasks, the other queue will store CPU bound tasks that are
> executed in a FIFO policy.

Oh as an aside btw - there are many real world workloads where we have a lot
of non cpu hog processes running. A lot of messaging systems have high task
switch rates but very few cpu hogs. So you still need to handle the non hogs
carefully to avoid degenerating back into Linus scheduler.
