Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132204AbQKCVjz>; Fri, 3 Nov 2000 16:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132207AbQKCVjp>; Fri, 3 Nov 2000 16:39:45 -0500
Received: from pop.gmx.net ([194.221.183.20]:11020 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132204AbQKCVje>;
	Fri, 3 Nov 2000 16:39:34 -0500
Message-ID: <001a01c045de$94695080$0301a8c0@home000.net>
From: "Thomas Kotzian" <thomas.kotzian@gmx.at>
To: <linux-kernel@vger.kernel.org>
Subject: Compiling 2.4.0-test10 on PPC
Date: Fri, 3 Nov 2000 22:39:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test10 doesn't compile correctly on a mac.
Only 2 changes are necessary to make it work.
Or are there any bigger problems with the ppc arch?

the 2 changes:
in ./include/asm-ppc/param.h the following lines have to be added
right before the last #endif:

#ifdef __KERNEL__
# define CLOCKS_PER_SEC 100 /* frequency at which times() counts */
#endif

in ./drivers/input/keybdev.c the second #elif (CONFIG_ADB) or
something like that should be changed to #else or the correct #elif
statement.

I don't know who's the maintainer of the ppc arch - i think ibm has
taken it over or am i wrong about that?

Thomas Kotzian

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
