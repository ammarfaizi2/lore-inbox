Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130085AbQK0RWK>; Mon, 27 Nov 2000 12:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130180AbQK0RWA>; Mon, 27 Nov 2000 12:22:00 -0500
Received: from sneaker.sch.bme.hu ([152.66.226.5]:65290 "EHLO
        sneaker.sch.bme.hu") by vger.kernel.org with ESMTP
        id <S130085AbQK0RVw>; Mon, 27 Nov 2000 12:21:52 -0500
Date: Mon, 27 Nov 2000 17:51:42 +0100 (CET)
From: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
Reply-To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <3A222DB3.2DE08804@uow.edu.au>
Message-ID: <Pine.LNX.3.96.1001127173748.9692C-100000@sneaker.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > In the afternoon we decided to put back the original mainboard+ram+cpu.
> > We booted the kernel described above.
> 
> With `noapic', I assume?
Yes, of course

> 
> It could be hardware or a driver or whatever.  Suggest you
> go to a more recent kernel and if the problems persist,
> swap hardware out.  Power supply, memory, CPUs, etc.
> 
...
> 
> We don't know.  It doesn't correlate with any particular chipset.
> Could be a hardware bug, a Linux bug or a chip errata which we don't
> know about.
> 

Another crash, and error message in this topic:
Kernel Panic: skput:over: a00f8d9b: 1526 put: 66 dev: eth1
In interrupt handler - not syncing

Because we have the SysRQ compiled, we tried the SysRQ + ALT + u
combination, to umount the partitions at least. After a big dump of hexa
numbers we got this:
Aiee, killing interrupt handler
Unable to handle kernel NULL pointer dereference

The eth1 is a dlink card, we use a driver from the cards developer. We use
this type of card with another computer since months ago, with the same
(2.2.14) kernel, and we didn't experience any problems yet. Of course I've
compiled the modul on the same computer where it's been run, and where
also the kernel has ben compiled and run.

The two cards in the two computers also have the same load (because they
are connected with a crosslink cable ;)

So I suppose it's not the fault of the network driver this time. I still
believe is somewhere around the apic.

I hope I could give You some more informations


+--------------------------------------------+
| Nagy Attila                                |
|   mailto:mrbig@sneaker.sch.bme.hu          |
+--------------------------------------------+


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
