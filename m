Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271847AbRH0TUH>; Mon, 27 Aug 2001 15:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271848AbRH0TT5>; Mon, 27 Aug 2001 15:19:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52232 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271847AbRH0TTh>; Mon, 27 Aug 2001 15:19:37 -0400
Subject: Re: memcpy to videoram eats too much CPU on ATI cards (cache trashing?)
To: shurdeek@panorama.sth.ac.at (Peter Surda)
Date: Mon, 27 Aug 2001 20:22:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010827201351.H17545@shurdeek.cb.ac.at> from "Peter Surda" at Aug 27, 2001 08:13:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bRy4-0004Va-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cause any CPU load (or more precisely, non-measurable load). However, with
> mach64 and r128, it DOES. I did some more research.

Makes sense

> memcpy-ing 380kB at 25fps takes about 5ms per frame and causes X to eat 1% cpu
> time (time measurements were done by tsc)
> memcpy-ing 760kB at 25fps takes about 11ms per frame, but instead of eating
> 2% CPU time, it eats 35% (yes, that's 35 times more)

So presumably at this bandwidth you are beginning collide with the graphics 
controllers and it will stall your cycles, at which point its going to stall
the CPU so effectively eat CPU time

Sounds like a reasonable explanation to me
