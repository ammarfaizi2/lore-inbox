Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132385AbRDCRbn>; Tue, 3 Apr 2001 13:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132389AbRDCRbd>; Tue, 3 Apr 2001 13:31:33 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:24326 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132385AbRDCRbU>; Tue, 3 Apr 2001 13:31:20 -0400
Message-ID: <3ACA08AD.1928A4E9@vc.cvut.cz>
Date: Tue, 03 Apr 2001 10:30:21 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: xcp <xcp@brewt.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: what is pci=biosirq
In-Reply-To: <Pine.LNX.4.30.0104022339450.20793-100000@stinky.brewt.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xcp wrote:

> Here is the output of lspci -vx -s 0:f.0
> 
> 00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
> (prog-if 8a [Master SecP PriP])
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at b000 [size=16]
> 00: b9 10 29 52 05 00 80 02 c1 8a 01 01 00 20 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 b0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 02 04
> 
> I'm not sure what to make of it.  At this time I am unable to
> append="pci=biosirq" as I don't use lilo.  Is there a way to put this
> arguement directly into the kernel image?

You probably can modify pci code to do that, but there is no reason for
you
to do it. Just ignore that message - your M5229 IDE reports that it
needs
some interrupt allocated to INTA. Fortunately IDE driver decided that
it should use IRQ 14 & 15 for this interface. So as long as it works, do
not pay any attention to biosirq message.
							Petr
