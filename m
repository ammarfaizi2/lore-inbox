Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131005AbQLUVOZ>; Thu, 21 Dec 2000 16:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131136AbQLUVOP>; Thu, 21 Dec 2000 16:14:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52099 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131005AbQLUVOB>; Thu, 21 Dec 2000 16:14:01 -0500
Date: Thu, 21 Dec 2000 15:43:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andre Hedrick <andre@linux-ide.org>
cc: safemode <safemode@voicenet.com>, Zdenek Kabelac <kabi@fi.muni.cz>,
        xOr <xor@x-o-r.net>, linux-kernel@vger.kernel.org
Subject: Re: Blow Torch (Re: lockups from heavy IDE/CD-ROM usage)
In-Reply-To: <Pine.LNX.4.10.10012211216060.566-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.95.1001221152807.12481A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000, Andre Hedrick wrote:

> On Thu, 21 Dec 2000, safemode wrote:
> 
> > I get this on the 440LX with the same DMA timeout message.  Everyone says it's
> > the board's fault as well.  Funny.   Anyways this happens accross just about
> > any Dev kernel but more so in the -test12 and up versions. .   Test10 works
> > fine without locking.  Blaming the hardware reminds me of the help given by
> > some other company I can't seem to remember the name to.
> 
> 29063507.pdf Page 22 sections 9,10
> What is the Intel solution to the is system hang?
> 
> 29063507.pdf Page 25 section 16
> Is this erratum valid to include all PIIX4-AB/EB, PIIX3, and PIIX a/b.
> 
> It is the DAMN hardware and quit BITCHING.
> I told everyone once that I was working on this issue.
> If you think you can fix it before me, be my guest.
> 
> I have given you the INTEL doc numbers and the page and the section.
> Go read.
> 
> Regards
> 

FYI, I havn't found a decent motherboard (chipset) amongst the new
boards released during the past year. Both ASUS and TYAN boards,
including the expensive "Thunderbolt", have the infamous "Bit 17"
memory errors, regardless of the amount/kind/speed/cost of SDRAM
installed.

If you get an Oops trace, see if the faulting address would be
correct if bit 17 was changed. There is something wrong with
the timing on the SDRAM controller so that all the timing skews
pile up, occasionally corrupting bit 17. This can't be by chance,
since I have now tested over 10 different systems, most with
different motherboards, and or course different sets of RAM from
single 32 MB sticks to 8 256 MB sticks, P-100, to 133 MHz, etc.

Every system has an occasional error with bit 17!  I even wrote
a memory-test program which shows this.

So, either the SDRAM controller used on these boards is bad,
or all the RAM produced by a half/dozen vendors over the past
year is bad. Take a choice.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0-test12 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
