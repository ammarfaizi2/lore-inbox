Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBONnx>; Thu, 15 Feb 2001 08:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129072AbRBONnn>; Thu, 15 Feb 2001 08:43:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129051AbRBONne>; Thu, 15 Feb 2001 08:43:34 -0500
Date: Thu, 15 Feb 2001 08:42:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Eli Carter <eli.carter@inet.com>
cc: tsbogend@alpha.franken.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Peter Missel <P.Missel@sbs-or.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcnet32.c: MAC address may be in CSR registers
In-Reply-To: <3A8B19BF.ED622DE5@inet.com>
Message-ID: <Pine.LNX.3.95.1010215083751.18223A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Eli Carter wrote:

> Eli Carter wrote:
> > I'm dealing with an AMD chip that does not have the station address in
> > the PROM at the base address, but resides in the "Physical Address
> > Registers" in the chip (thanks to the bootloader in my case).  This
> > patch makes the driver try those registers if the station address read
> > from the PROM is 00:00:00:00:00:00.
> > I think others dealing with similar setups may find this helpful.  The
> > other lance-derived drivers might benefit from a similar patch, but I
> > don't have that hardware for testing.
> 
> <aside>
> Added Peter since he's given feedback on a past pcnet32 patch.
> </aside>
> 
> Two patches, one for 2.2.18 (patch-pcnet32-mac22), and one for 2.4.1
> (patch-pcnet32-mac24) which should each apply cleanly.
> 
> Changes:
> - Moved address validity check to a function.  (Should this go somewhere
> other drivers can call it?)
> - Check the second address and set the address to 00:00:00:00:00:00 if
> it fails
> - Check the address at open time as well, failing with -EINVAL.
> 
> I think that should address Alan's initial feedback.
> 
> What else?
> 
> TIA,

Thanks for copying me on this. If, in the future, it seems reasonable,
I will supply a patch for the new read/write SEEPROM stuff needed for
embedded systems.

If you need to check if this device has a SEEPROM. If it doesn't,
you need to set up about 15 registers that would have been set
upon hard-reset, by the contents of the SEEPROM. Otherwise you
have a very dumb poorly performing chip.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


