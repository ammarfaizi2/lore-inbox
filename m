Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQLLVxQ>; Tue, 12 Dec 2000 16:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLLVxH>; Tue, 12 Dec 2000 16:53:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45575 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129385AbQLLVwx>; Tue, 12 Dec 2000 16:52:53 -0500
Subject: Re: 2.2.16 SMP: mtrr errors
To: johncavan@home.com (John Cavan)
Date: Tue, 12 Dec 2000 21:23:30 +0000 (GMT)
Cc: VANDROVE@vc.cvut.cz (Petr Vandrovec),
        pauly@enteract.com ( Paul C. Nendick), linux-kernel@vger.kernel.org
In-Reply-To: <3A3693A8.E0BA83B7@home.com> from "John Cavan" at Dec 12, 2000 04:07:52 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145wtZ-0001pn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Petr, the Matrox card splits the memory between the two video screens
> when running in a multi-head configuration and "pretends" that it is two
> distinct cards. Thus, a 32 mb card will register an mtrr for 24mb and
> for 8mb seperately when in this mode.

That is a driver bug. The intel processors only support MTRR's on certain
power boundaries/sizes. The fall through is intended. 

> to fall through, but is this correct? I've inserted a break at the end
> of the Intel switch before and have not had problems, but I left it out

Lucky

> in the latest couple of kernels because of all the mtrr work being done,
> waiting to see if there was resolution.

The Matrox driver needs to register a single 32Mb MTRR

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
