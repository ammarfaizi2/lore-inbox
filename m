Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbQLIAbe>; Fri, 8 Dec 2000 19:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbQLIAbZ>; Fri, 8 Dec 2000 19:31:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33043 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130163AbQLIAbG>; Fri, 8 Dec 2000 19:31:06 -0500
Subject: Re: Pthreads, linux, gdb, oh my! (fwd)
To: peterb@telerama.com (Peter Berger)
Date: Sat, 9 Dec 2000 00:02:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSI.4.02.10012081344430.26743-100000@frogger.telerama.com> from "Peter Berger" at Dec 08, 2000 02:43:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144XT2-0004fH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So you're saying that you got this to work?  Because I certainly couldn't
> get it working with a higher version either.  I would really love a

I read straight down it anf realised you referenced obsolete versions of
tg->created and thus broadcast incorrectly

> I apologize for my ignorance -- I frankly don't know the intricicies of
> linux kernel development; all I know is I wrote what might be the simplest
> of all possible concurrency tests and it is failing.  If someone could
> point me to a version or combination of linux and glibc where it doesn't
> fail, I'd be happy.

The way it works on the Linux side for threads is


Kernel provides
		Shared resources
		clone() - fork with sharing of files/memory etc

glibc provides
		POSIX semantics
		pthreads API
		thread locking on top of its own spin locks and kernel locks



Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
