Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbVG3Gei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVG3Gei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 02:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVG3Gei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 02:34:38 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:32414 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262957AbVG3Gef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 02:34:35 -0400
Date: Sat, 30 Jul 2005 02:34:53 -0400
From: Frank Peters <frank.peters@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: mkrufky@m1k.net, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050730023453.196a7477.frank.peters@comcast.net>
In-Reply-To: <20050729213724.01c61c26.akpm@osdl.org>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<42BC306A.1030904@m1k.net>
	<20050624125957.238204a4.frank.peters@comcast.net>
	<42BC3EFE.5090302@m1k.net>
	<20050728222838.64517cc9.akpm@osdl.org>
	<42E9C245.6050205@m1k.net>
	<20050728225433.6dbfecbe.akpm@osdl.org>
	<42EAF885.40008@m1k.net>
	<20050729213724.01c61c26.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 21:37:24 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> So I dunno, sorry.  Brute-force it with a git bisection search, perhaps?

I compiled 2.6.13-rc4 with ACPI debugging enabled.

During a failed boot, when the keyboard was unresponsive, I managed
to capture a kernel log of this failure.  Here are the lines that caught
my attention:

kernel: i8042.c: Can't read CTR while initializing i8042.
kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
kernel: ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 16
kernel: ttyS2 at I/O 0xb800 (irq = 16) is a 16550A

This error/warning message does not occur all the time, but it
has appeared at least twice during my brief experimentation and
I would consider it something that can be duplicated.

So far it is the only anomoly that I have seen anywhere, but it may
be more a result of the problem rather than the cause.

Frank Peters

