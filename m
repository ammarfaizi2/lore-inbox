Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311900AbSCOBvx>; Thu, 14 Mar 2002 20:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311901AbSCOBvn>; Thu, 14 Mar 2002 20:51:43 -0500
Received: from adsl-64-169-88-198.dsl.snfc21.pacbell.net ([64.169.88.198]:2691
	"EHLO fokker") by vger.kernel.org with ESMTP id <S311900AbSCOBvh>;
	Thu, 14 Mar 2002 20:51:37 -0500
Message-ID: <3C9153A7.292C320@ianduggan.net>
Date: Thu, 14 Mar 2002 17:51:35 -0800
From: Ian Duggan <ian@ianduggan.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18+mki+w4l i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>, linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18 Preempt Freezeups
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I seem to be getting some odd behavior that I think may be related to
the preempt patch somehow.


Problem:
--------

The machine completely hangs with the exception of constantly repeating
the same 1/4 second sound sample that happens to be playing at the time
of the hang. The kernel does not respond to network traffic, nor to
SYS-REQ commands. A hard reset is all that works at this point.


CPU, Kernels and Patches:
-------------------------

Dual Pentium III 450MHz, SMP Kernels


Stock 2.4.17+preempt+lock-break+mki-adapter+win4lin

	- Problem extremely intermittent, maybe once a day.


Stock 2.4.18+preempt+mki-adapter+win4lin

	- Very frequent, and also repeatable every time I
		try to start win4lin.


Stock 2.4.18+mki-adapter+win4lin

	- No problems thus far. Win4lin works fine.



The mki-adapter and win4lin patches are needed for win4lin to work. I
include them here because it seems to be some sort of interaction
between them and preempt, or some behavior that they can evoke
repeatable which causes the problem to surface.

The problem could easily be somewhere in the win4lin stuff, and preempt
causes it to appear there.

What can I do to try to hunt down this problem, given that the machine
is completly useless once it happens?

-- Ian

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ian Duggan                    ian@ianduggan.net
                              http://www.ianduggan.net
