Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277112AbRKHRzq>; Thu, 8 Nov 2001 12:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRKHRz0>; Thu, 8 Nov 2001 12:55:26 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:25355 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277068AbRKHRzP>;
	Thu, 8 Nov 2001 12:55:15 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111081754.UAA24454@ms2.inr.ac.ru>
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
To: davem@redhat.com (David S. Miller)
Date: Thu, 8 Nov 2001 20:54:29 +0300 (MSK)
Cc: tim@physik3.uni-rostock.de, jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        adilger@turbolabs.com, netdev@oss.sgi.com, ak@muc.de
In-Reply-To: <20011107.160950.57890584.davem@redhat.com> from "David S. Miller" at Nov 7, 1 04:09:50 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>    jiffies cleanup patch of the day follows. Mostly boring changes of jiffies
>    comparisons to use time_{before,after} in order to handle jiffies
>    wraparound correctly.

I want to _ask_ one thing people working on these changes.
_Please_, defer this edit to 2.5. The changes are very good,
but time for them is very bad.

When I wrote this code the macros did not exist. However, this code is right,
take my word. Hence, it is pure maintanance problem and as soon as
main reader of this code is me, I would be glad to see the changes,
but only having no deadlines.

Anyway, if someone want to try to define jiffies as somewhat
different of "unsigned long", all code needs real checking rather
than syntax changes.

Alexey
