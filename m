Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSLWAlN>; Sun, 22 Dec 2002 19:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSLWAlN>; Sun, 22 Dec 2002 19:41:13 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:46005 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265201AbSLWAlM> convert rfc822-to-8bit; Sun, 22 Dec 2002 19:41:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - exit_weight
Date: Mon, 23 Dec 2002 01:49:01 +0100
User-Agent: KMail/1.4.3
Cc: Con Kolivas <conman@kolivas.net>
References: <200212220818.22906.conman@kolivas.net>
In-Reply-To: <200212220818.22906.conman@kolivas.net>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212230148.16806.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 December 2002 22:18, Con Kolivas wrote:

Hey Con,

> osdl hardware, contest results, 2.5.52-mm2 with scheduler tunable - exit
> weight (ew1= exit weight ==1 and so on)
Can you please try another thing?

kernel/sched.c

        /*
         * If the child was a (relative-) CPU hog then decrease
         * the sleep_avg of the parent as well.  
         */
        if (p->sleep_avg < p->parent->sleep_avg)
                p->parent->sleep_avg = (p->parent->sleep_avg * exit_weight +
                        p->sleep_avg) / (exit_weight + 1);

Remove these please and run again.

ciao, Marc
