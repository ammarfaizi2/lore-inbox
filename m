Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSILQZY>; Thu, 12 Sep 2002 12:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSILQZY>; Thu, 12 Sep 2002 12:25:24 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:16399 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S316580AbSILQZX> convert rfc822-to-8bit;
	Thu, 12 Sep 2002 12:25:23 -0400
Date: Thu, 12 Sep 2002 19:30:12 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: pk@edu.joroinen.fi
To: linux-kernel@vger.kernel.org
Subject: sched.h changes in 2.4.19rc5aa1 / Digi's cpci driver doesn't compile
Message-ID: <Pine.LNX.4.44.0209121923320.17322-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I'm using Linux 2.4.19rc5aa1 and having problems to compile Digi's cpci
driver for multiport serialboard. This driver is not part of the kernel,
but available from Digi's website.

The problem seems to be related to changes in include/linux/sched.h.
Digi's driver wants to use member called "counter" which doesn't exist
anymore in the -aa kernel.

The code goes like this (cpci.c line 3847):

	current->state = TASK_INTERRUPTIBLE;
	current->counter = 0;   /* make us low-priority */

current is task_struct.

Sources available from http://nrg.joroinen.fi/digi/

Any ideas how to fix this? I'm not familiar with kernel driver
development..


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

