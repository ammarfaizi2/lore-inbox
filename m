Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTJFUIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbTJFUIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:08:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261670AbTJFUIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:08:40 -0400
Date: Mon, 6 Oct 2003 16:08:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pascal Schmidt <der.eremit@email.de>
cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <E1A6aWv-0000rJ-00@neptune.local>
Message-ID: <Pine.LNX.4.53.0310061605001.733@chaos>
References: <DIre.Cy.15@gated-at.bofh.it> <DIre.Cy.17@gated-at.bofh.it>
 <DIre.Cy.19@gated-at.bofh.it> <DIre.Cy.13@gated-at.bofh.it>
 <DIAQ.2Hh.5@gated-at.bofh.it> <E1A6aWv-0000rJ-00@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Pascal Schmidt wrote:

> On Mon, 06 Oct 2003 20:50:12 +0200, you wrote in linux.kernel:
>
> > That has no bearing on the legalities.  A version of the kernel can't
> > force the GPL on a driver that works with that version of the kernel
> > because you can pull that driver out and drop in another.
>
> Okay, I can see the boundary. We still have the problem that drivers
> writers have to be very careful to not copy kernel code by accident
> because the kernel changes often, which creates a temptation to look
> closely at in-tree drivers to see how they do things. And if a
> drivers writer then produces code that is essentialy the same as is
> found in the kernel, only with changed indentation and variable names,
> I think we both a agree that such a driver would be a derived work.
>
> Another problem is the fact that Linux kernel headers can contain code
> in the form of macros. If a driver uses such a header, it links kernel
> code with itself which can easily make it a derived work.
>
> --
> Ciao,
> Pascal


Statement of the problem:

A company makes a new device that could run under Linux.
This device uses some standard gate-arrays. Because of
this, some gate-array bits need to be loaded upon startup.

The company knows that if the competition learns that a
gate-array was used, instead of an ASIC, the competition
could clone the whole device in a few weeks, thereby
stealing a few million dollars of development effort.
In fact, the thieves don't even need to buy an initial
board to copy. They just need the GPL source-code of
the driver.

The thieves need only to get a copy of the bits and
the device type of the gate-array. They then have
the entire design at-hand without ever doing any
Engineering at all. This will give the thieves an
unfair marketing advantage, allowing them to sell
the device at a cheaper amount and still make money.

For Linux to be more widely accepted by the hardware
community, there needs to be some way of protecting
the investment that the hardware companies have made.
They need to be able to hide the implementation details
from the competition. For this, they currently need to
link their GPL module-code against some secret code
that is not released to the general public.

Unfortunately, any code that can execute in the kernel
can throughly corrupt other kernel code. This has led
some to create the "Tainted" advice, etc. It may be
possible to work around the bug-reporting problem if
the module is not a disk-interface module or a screen-
interface module. Just remove the module, verify the
bug still exists, then submit a report. However, many
modules can't be removed and still have a running
system. Therefore the "Tainted" fix doesn't work.

So, instead of arguing, forever, about what's GPL
and what's not GPL, it would be real nice if the same
amount of effort was expended towards fixing the
basic problem.

The basic problem is that, in many cases, a hardware
vendor cannot divulge the inner workings of his hardware.
Even if the hardware vendor wanted to be a "nice guy"
and let everybody know how his board worked, if the
company was being publically-traded, the stock-holders
could (read would) sue and whomever released the information
could (read would) be found guilty of stealing or
divulging trade-secrets.

So, let's figure out how to protect the inner workings
of the kernel while, at the same time, protecting a
hardware vendor's engineering investment.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


