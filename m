Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIRjO>; Tue, 9 Jan 2001 12:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIRjG>; Tue, 9 Jan 2001 12:39:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15885 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129226AbRAIRiy>; Tue, 9 Jan 2001 12:38:54 -0500
Subject: Re: wavelan has fatal error with 2.4.0 (but worked in 2.4.0-test12)
To: jt@hpl.hp.com
Date: Tue, 9 Jan 2001 17:13:42 +0000 (GMT)
Cc: rutt@chezrutt.com (John Ruttenberg),
        linux-kernel@vger.kernel.org (Linux kernel mailing list),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010109090427.A30175@bougret.hpl.hp.com> from "Jean Tourrilhes" at Jan 09, 2001 09:04:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G2LB-0006zy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	This is a bug with the definition of udelay(). Somebody tried
> to be too clever with udelay(), and the end result is that it breaks
> perfectly good and valid code.
> 	Therefore, it should be reported as such on LKML, a bug in udelay().

It is a bug in the driver.

> there. For my part, I insist that the code is correct, that replacing
> an inline function by a #define is going backwards and that udelay()
> should be fixed one way or another (easy, just define __bad_udelay()
> as returning a compilation warning or an error message).

You can't #define a function to a #warning or #error in C. Language limitation

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
