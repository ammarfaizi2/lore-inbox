Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbQLLAnC>; Mon, 11 Dec 2000 19:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131387AbQLLAmw>; Mon, 11 Dec 2000 19:42:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35345 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131369AbQLLAmi>; Mon, 11 Dec 2000 19:42:38 -0500
Subject: Re: bug in scsi.c
To: asklein@cip.physik.uni-wuerzburg.de (Andreas Klein)
Date: Tue, 12 Dec 2000 00:14:10 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GHP.4.21.0012120044390.20976-100000@wpax13.physik.uni-wuerzburg.de> from "Andreas Klein" at Dec 12, 2000 01:09:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145d5B-0000Nn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In sched.c, function daemonize, line 1216 you call exit_mm.

Yep

> time, it has to segvault. If I am not wrong at this point CLONE_VM simply
> has to be removed from kernel_thread. The kernel-thread will free his mem
> in daemonize (calling exit_mm) and the user-space-application will free
> the mem when exiting.

Providing the use counter is being bumped properly it wont go away any more
than if a thread of a user space app exits before the others as far as I can
see



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
