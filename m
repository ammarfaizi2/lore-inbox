Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311834AbSCNWZN>; Thu, 14 Mar 2002 17:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311835AbSCNWZD>; Thu, 14 Mar 2002 17:25:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311834AbSCNWYy>; Thu, 14 Mar 2002 17:24:54 -0500
Date: Thu, 14 Mar 2002 17:25:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <3C912227.3080806@zytor.com>
Message-ID: <Pine.LNX.3.95.1020314172335.715C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, H. Peter Anvin wrote:

> Richard B. Johnson wrote:
> 
> > 
> > Yeh?  Then "how do it know?". It doesn't. I/O instructions are ordered,
> > however, that's all. There is no bus-interface state machine that exists
> > except on the addressed device. The CPU driven interface device just
> > makes sure that the data is valid before the address and I/O-read or
> > I/O-write are valid after this. The address is decoded by the device
> > and is used to enable the device. It either puts its data onto the
> > bus in the case of a read, or gets data off the bus, in the case of
> > a write. The interface timing is specified and is handled by hardware.
> > In the meantime the CPU has not waited because there is nothing to
> > wait for. On a READ, if the device cannot put its data on the bus
> > fast enough, it puts its finger io IO-chan-ready. This forces the
> > CPU (through its bus-interface) to wait.
> > 
> > Writes to nowhere are just that, writes to nowhere.
> > 
> 
> 
> On the ISA bus, yes.  The PCI and front side busses will be held in wait 
> until the transaction is completed.
> 
> The exact requirement is a bit more complicated, something along the 
> lines of "an SMI triggered in response to an OUT will be taken before 
> the OUT is retired."
> 

Correct! The PCI is very much different, I'm glad, and hopefully nobody
will be using that for deliberate waits.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

