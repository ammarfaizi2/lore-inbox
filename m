Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286140AbRLJBLH>; Sun, 9 Dec 2001 20:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286132AbRLJBJu>; Sun, 9 Dec 2001 20:09:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286131AbRLJBIx>; Sun, 9 Dec 2001 20:08:53 -0500
Subject: Re: [RFC] Scheduler queue implementation ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Mon, 10 Dec 2001 01:18:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.40.0112091701000.996-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 09, 2001 05:06:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DF5E-00009N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > of non cpu hog processes running. A lot of messaging systems have high task
> > switch rates but very few cpu hogs. So you still need to handle the non hogs
> > carefully to avoid degenerating back into Linus scheduler.
> 
> In my experience, if you've I/O bound tasks that lead to a long run queue,
> that means that you're suffering major kernel latency problems ( other than the
> scheduler ).

I don't see any evidence of it in the profiles. Its just that a lot of stuff
gets passed around between multiple daemons. You can see similar things
in something as mundane as a 4 task long pipe, a user mode file system or
some X11 clients.
