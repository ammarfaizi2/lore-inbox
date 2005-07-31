Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVGaUn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVGaUn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVGaUn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:43:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261883AbVGaUnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:43:55 -0400
Date: Sun, 31 Jul 2005 13:42:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank Peters <frank.peters@comcast.net>
Cc: vojtech@suse.cz, mkrufky@m1k.net, linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050731134245.742b9fc2.akpm@osdl.org>
In-Reply-To: <20050731152406.200fe1c1.frank.peters@comcast.net>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<42BC306A.1030904@m1k.net>
	<20050624125957.238204a4.frank.peters@comcast.net>
	<42BC3EFE.5090302@m1k.net>
	<20050728222838.64517cc9.akpm@osdl.org>
	<42E9C245.6050205@m1k.net>
	<20050728225433.6dbfecbe.akpm@osdl.org>
	<42EAF885.40008@m1k.net>
	<20050729213724.01c61c26.akpm@osdl.org>
	<20050730023453.196a7477.frank.peters@comcast.net>
	<20050731184532.GA9026@ucw.cz>
	<20050731152406.200fe1c1.frank.peters@comcast.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Peters <frank.peters@comcast.net> wrote:
>
> On Sun, 31 Jul 2005 20:45:32 +0200
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > > 
> > > During a failed boot, when the keyboard was unresponsive, I managed
> > > to capture a kernel log of this failure.  Here are the lines that caught
> > > my attention:
> > > 
> > > kernel: i8042.c: Can't read CTR while initializing i8042.
> > > kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> > > kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > > kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> > > kernel: ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 16
> > > kernel: ttyS2 at I/O 0xb800 (irq = 16) is a 16550A
> > > 
> >  
> > Please try 'usb-handoff' on the kernel command line. This looks like an
> > usual symptom on machines that need it.
> > 
> > 
> >
> 
> It works!  :-)))
> 
> Booting linux-2.6.13-rc4 with the "usb-handoff" option gives me
> a working keyboard everytime now.

But 2.6.12 did not require this workaround, yes?

