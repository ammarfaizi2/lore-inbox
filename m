Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319577AbSIHHpw>; Sun, 8 Sep 2002 03:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319576AbSIHHpw>; Sun, 8 Sep 2002 03:45:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39112 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319577AbSIHHpv>;
	Sun, 8 Sep 2002 03:45:51 -0400
Date: Sun, 8 Sep 2002 09:55:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209072342450.1096-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0209080952410.16565-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Sep 2002, Zwane Mwaikambo wrote:

> 	What do you make of the following patch. It is supposed to ease
> irq sharing by allowing multiple isrs to be executed, but still not
> allowing a specific isr to be run asynchronously. I haven't been able to
> test it on SMP proper, only SMP kernel on UP machine and using a shared
> network card and sound card concurrently with an interrupt load of
> ~3000irqs/s

hm, perhaps it could confuse some of the more complex shared-IRQ-aware
device drivers, such as IDE. But your patch is very tempting nevertheless,
it removes much of the disadvantage of sharing interrupt lines. Most of
the handlers on the chain are supposed to be completely independent.

	Ingo

