Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153947-6332>; Tue, 24 Nov 1998 00:04:07 -0500
Received: from snowcrash.cymru.net ([163.164.160.3]:1297 "EHLO snowcrash.cymru.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154467-6332>; Mon, 23 Nov 1998 17:09:41 -0500
Message-Id: <m0zi6M1-0007U1C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: differences in between 2.0 and 2.1 SMP?
To: losi@altrimedia.it
Date: Tue, 24 Nov 1998 00:29:16 +0000 (GMT)
Cc: linux-kernel@vger.rutgers.edu
In-Reply-To: <36599C9E.D100032F@altrimedia.it> from "root" at Nov 23, 98 05:34:22 pm
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

> What are the architectural differences between SMP code in 2.0 and 2.1?
> I'm a very beginner kernel hacker and I'm still in the code grepping
> stage...
> it seems to me that only one of the CPUs can execute the kernel code...
> is that correct?

2.0.x only one CPU is _running_ in kernel at a time (others may be sleeping
on things but inside a kernel sleep). IRQs are forwarded to the CPU that
has the lock

2.1.x IRQs are taken on all CPUs spin locks guard data structures some kernel
subsystems are not subject to the main kernel lock at all


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
