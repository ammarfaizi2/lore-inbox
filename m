Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270973AbRHTB2W>; Sun, 19 Aug 2001 21:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270979AbRHTB2D>; Sun, 19 Aug 2001 21:28:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64129 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270973AbRHTB1w>; Sun, 19 Aug 2001 21:27:52 -0400
Date: Sun, 19 Aug 2001 21:27:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Adrian Cox <adrian@humboldt.co.uk>
cc: Nicholas Knight <tegeran@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <3B7E2CA5.50904@humboldt.co.uk>
Message-ID: <Pine.LNX.3.95.1010819211427.28054B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Adrian Cox wrote:

> Richard B. Johnson wrote:
> > We've established no such thing. In fact, you can't properly initialize
> > SDRAM memory without writing something to it. 
> 
> After all of this theory it was time to do some experiments. I modified 
> the BIOS on my current PowerPC system to compare memory against a test 
> pattern (I chose 0x31415926 incrementing by 0x27182817) over the address 
> range 0x0 to 0x100000. This pattern has approximately 50% 1s and 50% 0s.
> 
> On pressing the reset button, I got 100% of bits holding the same value. 
> If I turn the power off for 20s, I get approximately 90% of bits holding 
> the same value. After a minute, it's dropped to the 50% level, which I 
> take as random.
> 
> For added fun, I then tried turning off, pulling out the DIMM, plugging 
> it into the other slot, and turning back on. 97% of the bits had the 
> original value. So one attack we must consider is the attacker removing 
> power, ripping the DIMM out, and plugging it into a special DIMM reading 
> device.
> 
> Your descriptions on how memory is started look very machine specific. 
> On mine (Motorola MPC107) I write the number of row bits, column bits, 
> and internal banks to the memory controller, along with the CAS latency. 
> I then set MEMGO, and the memory controller precharges each bank.
> -- 
> Adrian Cox   http://www.humboldt.co.uk/
> 

Look. I have a boundary-scan probe hardware debugger. I can set
a breakpoint anywhere on my SC520 evaluation board and on the
target which as been in production for 1/2 year. It uses SDRAM
and, as I stated, SDRAM will lose its information as part of
the required initialization sequence. This is not theory. This
is fact.

Your idea of removing the RAM from the board and reading it
from a RAM-reader may actually show some valid data. However,
it is well thown that physical access to a machine or its
components while the power is applied and the machine is
running eliminates any possibility of security anyway.
You just keep the machine on its UPS and carry it away.

The "feds" just compile and install a module to look at
anything they want.

If you want some kind of security, you need to at least
hit the reset button before the feds carry it away.
The normal initialization of SDRAM will wipe out whatever
it has, and you can't get it back on-line without this
sequence.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


