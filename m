Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272115AbRHVUmN>; Wed, 22 Aug 2001 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272116AbRHVUmD>; Wed, 22 Aug 2001 16:42:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17285 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272115AbRHVUlz>; Wed, 22 Aug 2001 16:41:55 -0400
Date: Wed, 22 Aug 2001 16:42:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Torri <storri@ameritech.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8-ac7: all serial ports not setup
In-Reply-To: <Pine.LNX.4.33.0108221201210.8546-100000@base.torri.linux>
Message-ID: <Pine.LNX.3.95.1010822163624.29158A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Stephen Torri wrote:

> I am using 2.4.8-ac7 on a Dual P3@450Mhz. The machine has two serial
> ports. ttyS0 & ttyS2 are covered by the first with ttyS1 & ttyS3 covered
> by the second. Now typically in /proc/interrupts only one serial port is
> configured. The IRQs 3 & 4 are shared by the two ports. Its not consistent
> which one gets which IRQ. Sometimes the first has 3 and the second 4.
> Today the situation is reversed. This ofcourse is wreaking havoc on
> setting my pilot for synchronization.
> 
> Is there a options that I failed to select while configuring the kernel?
> Do I need to add an option to the boot via lilo?
> 
> I will do an idiot check by checking the bios.
> 
> Stephen
> 
> -

Don't know about 'modern' distributions, but serial ports are normally
set up only when they are used. `man setserial`. In the 2.x.x kernels,
the IRQs are assigned only when a device is opened. The IRQs are
released when the device is closed.

Why would you care what IRQ is being used for serial I/O? The API doesn't
even know. What do you mean by; "setting my pilot for synchronization"?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


