Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbQKESNO>; Sun, 5 Nov 2000 13:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQKESNE>; Sun, 5 Nov 2000 13:13:04 -0500
Received: from [212.115.175.146] ([212.115.175.146]:51440 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129810AbQKESMt>; Sun, 5 Nov 2000 13:12:49 -0500
Message-ID: <27525795B28BD311B28D00500481B7601623D9@ftrs1.intranet.FTR.NL>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: "'Robert M. Love'" <rml@tech9.net>
Cc: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: RE: i82808 hardware hub RNG
Date: Sun, 5 Nov 2000 19:16:39 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Excellent!
> Got any URLs?
RML> its been in 2.4 for a year or so, although only in the last few tests
as
RML> it supported i815. it has been in 2.2 since 2.2.17 or the current
2.2.18.

2.2.18 I think, or some undetected disk-error must have swept it away from
the local sourcetree :o)

RML> take a look at linux/drivers/char/i810_rng.c
RML> Jeff's homepage for it is http://gtf.org/garzik/drivers/i810_rng/ but
RML> probably not as up to date as the C source.

Thank you!

RML> it works great for me. i have it feeding the standard entropy pool, so
my
RML> /dev/random is fat with entropy.

You didn't forget to change the line
random.c: #define POOLWORDS 128    /* Power of 2 - note that this is 32-bit
words */
to
#define POOLWORDS 2048    /* Power of 2 - note that this is 32-bit words */
? :o)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
