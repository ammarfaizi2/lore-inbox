Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2RuF>; Mon, 29 Jan 2001 12:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbRA2Rtz>; Mon, 29 Jan 2001 12:49:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35716 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129101AbRA2Rtn>; Mon, 29 Jan 2001 12:49:43 -0500
Date: Mon, 29 Jan 2001 12:48:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Craig I. Hagan" <hagan@cih.com>
cc: Romain Kang <romain@kzsu.stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 - Linux vs. FreeBSD
In-Reply-To: <Pine.LNX.4.20.0101291231520.30022-100000@www.cih.com>
Message-ID: <Pine.LNX.3.95.1010129123830.562A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Craig I. Hagan wrote:

> > One approach to the endless eepro100 headaches would be to port
> > the FreeBSD if_fxp driver to Linux.  After all, drivers have been
> > ported between these OSs before; e.g., the aic7xxx SCSI adapter.
> > However, I see no evidence that this has been attempted.  Can
> > someone tell me what I'm obviously missing?
> 
> Had I my druthers, i'd see the intel e100 driver brought into the kernel. It
> seems to work quite well with the eepro100 boards.
> 

Two of my Linux machines use the Intel Ethernet controller on the
motherboard. These are both SMP machines. I have never, ever, had
any problems with the eepro100 driver that handles these chips.

I spite of the fact that the driver loops in the ISR, and does other
things that show poor design, it works so I have not done anything
to it. "If it ain't broke, don't fix it..."

So, if you have problems with using on-board Intel chip, it's
unlikely that it's a driver problem. If you have cards on the PCI
bus, the driver doesn't "know" any difference (PCI is PCI even if
it's not in a connector). You may find that the problem is caused
by PCI (mis)configuration since recent kernels use internal PCI
code. You may find that some bus master device does not have its
latency set correctly so it's taking over the bus. This can cause
problems with any high-activity device on the bus, such as a
network device.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
