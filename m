Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbRLJACV>; Sun, 9 Dec 2001 19:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286100AbRLJACM>; Sun, 9 Dec 2001 19:02:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55570 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284717AbRLJAB7>; Sun, 9 Dec 2001 19:01:59 -0500
Subject: Re: [RFC][PATCH] 2.5.0 Multi-Queue Scheduler
To: kravetz@us.ibm.com (Mike Kravetz)
Date: Mon, 10 Dec 2001 00:10:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20011209145352.C1087@w-mikek2.sequent.com> from "Mike Kravetz" at Dec 09, 2001 02:53:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DE21-0008Md-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That makes it much easier.  When we tried this, we were going for
> strict priority.  Therefore, you either had a really large number
> of queues, or you had to scan all tasks on individual queues.  Again,
> we were trying to maintain existing behavior.  In hind sight, this
> doesn't look like a smart design constraint. :)

I'm actually trying to behave roughly like Linus old scheduler does at
least in the general cases. Hence the queues are priority based, the tasks
are run priority first and drop priority rather than the standard multi
level queue where you run each queue for certain slots.

Alan

