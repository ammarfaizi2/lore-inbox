Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUCESBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCESBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:01:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41347 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262665AbUCESBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:01:35 -0500
Date: Fri, 5 Mar 2004 13:04:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 'simulator' and wave-form analysis tool?
In-Reply-To: <4048B36E.8000605@techsource.com>
Message-ID: <Pine.LNX.4.53.0403051253220.32349@chaos>
References: <4048B36E.8000605@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004, Timothy Miller wrote:

> I wouldn't be surprised if someone's already done this, but...
>
> I'm a chip designer, and when we design a chip, before we put it in
> silicon, we use simulator tools that emulate the logic we designed.  One
> of the most important parts of the simulator is the wave-form analyzer.
>   We run the simulator for some period of time, and then we can look at
> the history of every signal in the design.
>
> Well, I've been looking at Bochs, and it has this 'instrumentation'
> facility which you can use to track everything that goes on in its
> simulation of an x86 processor.  If I were to put a hook in to track all
> memory writes, then I could record all memory activity (I could hook
> much more!).  When a crash occurs, someone could use the analogue to the
> wave-form tool to trace execution back to the event that caused the
> problem (because, for instance, heap corruption causes crashes much
> later than the bug).
>
> Would it be a productive use of my time to work on this?
>

If you are making hardware that goes between the CPU and the
rest of the world, then you can keep track of anything that's
going on with some hardware-software combination, external
to the chip you are analyzing. These things exist and they
are called emulators, even though most don't emulate anything,
they use the real chip, but provide the physical and logical
connections to the user. However, in the case of an already-made
machine, you are limited in what you can do on the machine
with software. For instance, to trap every memory access, you
would need a trap-handler and set all the memory to trap
on an access. This would a bit hard to do within the kernel
because all the code on that page would trap as instructions
were fetched. So, some mere "hook" won't do it, you need
a kernel that executes a kernel and I think one for Linux
already exists. So, before you get too involved, you might
want to check that out.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


