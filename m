Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318710AbSICFqU>; Tue, 3 Sep 2002 01:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318714AbSICFqU>; Tue, 3 Sep 2002 01:46:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38355 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318710AbSICFqT>;
	Tue, 3 Sep 2002 01:46:19 -0400
Date: Tue, 3 Sep 2002 07:54:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209022322230.11866-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0209030750380.2379-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Sep 2002, Tobias Ringstrom wrote:

> But I still do not understand why the process is classified as
> non-interactive...  Around 20 times per second it does a nanosleep for 1
> ms which takes around 40 ms in reality.  (Seeing this makes me believe
> that I should try to increase HZ, but that is a separate issue.)

what CPU usage does it have? 70% CPU usage is not interactive.

well, even 70% CPU usage can be interactive if you lower its priority to
-20. But with the default nice value a task will lose its interactivity
much quicker.

also, could you increase HZ to 1000 (in asm/param.h, full recompile of the
kernel is needed), does it make a difference?

	Ingo

