Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbRBBTSS>; Fri, 2 Feb 2001 14:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBBTSI>; Fri, 2 Feb 2001 14:18:08 -0500
Received: from fungus.teststation.com ([212.32.186.211]:37018 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129094AbRBBTSC>; Fri, 2 Feb 2001 14:18:02 -0500
Date: Fri, 2 Feb 2001 20:17:45 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Jonathan Morton <chromi@cyberspace.org>
cc: <linux-kernel@vger.kernel.org>, <T.Stewart@student.umist.ac.uk>
Subject: Re: DFE-530TX with no mac address
In-Reply-To: <l03130310b6a0ac26266f@[192.168.239.105]>
Message-ID: <Pine.LNX.4.30.0102021953560.10971-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >I did this and compiled it into the kernel. It detects it at boot (via-
> >rhine v1.08-LK1.1.6 8/9/2000 Donald Becker) but says the
> >hardware address (mac address?) is 00-00-00-00-00-00.

This is a good example of what is missed by not copying the exact message.
For example, mine says:

eth0: VIA VT3043 Rhine at 0xd400, 00:50:ba:a4:15:86, IRQ 19.
eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link 0000.

Does it say "VIA VT6102 Rhine-II" for both of you?
If not, could you do an 'lspci -n'?

My VT3043 survives win98, but it may be a new feature in the newer chip. 
It may be a bios setting or something ...


> I have an identical card, which usually works - except when I've rebooted
> from Windows, when it shows the above symptoms.  After using Windows, I
> have to power the machine off, including turning off the "standby power"
> switch on the PSU, then turn it back on and boot straight into Linux.  Very
> occasionally it also loses "identity" and requires a similar reset, even
> when running Linux.

Yes, the card is in some (for the linux driver) unknown state. Powering
off completely resets it. Something that could help someone find out what
is going on is running these two commands, both when the card is working
and when it is not.

via-diag -aaeemm
lspci -vvvxxx -d 1106:3065

via-diag is available from http://www.scyld.com/diag/index.html

(1106:3065 is the pci id, if lspci -n gives you a different number you use 
 that of course.)

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
