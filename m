Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261781AbSI2UV5>; Sun, 29 Sep 2002 16:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261773AbSI2UVN>; Sun, 29 Sep 2002 16:21:13 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:272 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261793AbSI2UT2>; Sun, 29 Sep 2002 16:19:28 -0400
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <Pine.LNX.4.44.0209291511250.24805-100000@montezuma.mastecende.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Sun, 29 Sep 2002 22:24:41 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, twaugh@redhat.com,
       serial24@macrolink.com, Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17vkcL-0007OZ-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I submitted both a parport sharing (i am using interrupt driven parport, 
> which is needed due to both serial ports using the same irq) and netmos 
> patch a while ago, Tim was concerned about issues encountered 
> by folks previously wrt the netmos.

What are these issues?  If they are caused by IRQ sharing between
parallel and serial ports, and parport works fine in polling mode
(it does for me, I've done quite a lot of printing), I'd suggest
to use polling for now, and leave IRQ sharing support for later...

Serial ports are more important for me right now, but 2S1P cards
are easier to find and even cheaper (!) than 2S cards...  There is
a disadvantage - extra slot (or holes in the back of the box) needed
for the two DB9 connectors connected to the card with ribbon cables.

The parport_serial / serial link order issue is quite old - is
everyone using modular kernels (not affected by it) these days?
Perhaps all of parport_serial should still be CONFIG_EXPERIMENTAL ;)

Marek

