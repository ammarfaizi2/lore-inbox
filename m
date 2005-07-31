Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVGaSpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVGaSpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVGaSpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:45:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:10456 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S261873AbVGaSpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:45:32 -0400
Date: Sun, 31 Jul 2005 20:45:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Frank Peters <frank.peters@comcast.net>
Cc: Andrew Morton <akpm@osdl.org>, mkrufky@m1k.net,
       linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-ID: <20050731184532.GA9026@ucw.cz>
References: <20050624113404.198d254c.frank.peters@comcast.net> <42BC306A.1030904@m1k.net> <20050624125957.238204a4.frank.peters@comcast.net> <42BC3EFE.5090302@m1k.net> <20050728222838.64517cc9.akpm@osdl.org> <42E9C245.6050205@m1k.net> <20050728225433.6dbfecbe.akpm@osdl.org> <42EAF885.40008@m1k.net> <20050729213724.01c61c26.akpm@osdl.org> <20050730023453.196a7477.frank.peters@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730023453.196a7477.frank.peters@comcast.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 02:34:53AM -0400, Frank Peters wrote:
> On Fri, 29 Jul 2005 21:37:24 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > So I dunno, sorry.  Brute-force it with a git bisection search, perhaps?
> 
> I compiled 2.6.13-rc4 with ACPI debugging enabled.
> 
> During a failed boot, when the keyboard was unresponsive, I managed
> to capture a kernel log of this failure.  Here are the lines that caught
> my attention:
> 
> kernel: i8042.c: Can't read CTR while initializing i8042.
> kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> kernel: ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 16
> kernel: ttyS2 at I/O 0xb800 (irq = 16) is a 16550A
> 
> This error/warning message does not occur all the time, but it
> has appeared at least twice during my brief experimentation and
> I would consider it something that can be duplicated.
> 
> So far it is the only anomoly that I have seen anywhere, but it may
> be more a result of the problem rather than the cause.
 
Please try 'usb-handoff' on the kernel command line. This looks like an
usual symptom on machines that need it.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
