Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132651AbRDGNb7>; Sat, 7 Apr 2001 09:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132652AbRDGNbt>; Sat, 7 Apr 2001 09:31:49 -0400
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:25279 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S132651AbRDGNbe>; Sat, 7 Apr 2001 09:31:34 -0400
Message-ID: <3ACF1525.88BCA48B@didntduck.org>
Date: Sat, 07 Apr 2001 09:24:53 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>
CC: Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <Pine.LNX.4.10.10104071043360.1085-100000@linux.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> 
> On Sat, 7 Apr 2001, Michael Reinelt wrote:
> 
> > Hi there,
> >
> > I've got a problem with my communication card: It's a PCI card with a
> > NetMos chip, and it provides two serial and one parallel port. It's not
> > officially supported by the linux kernel, so I wrote my own patch and
> > sent it to the parallel, serial and pci maintainer. The patch itself is
> > basically an extension of the pci id tables; and I hope it's in the
> > queue for the official kernel.
> >
> > The patch worked great for me with kernel 2.4.1 and .2, but no longer
> > with 2.4.3. The parallel port still works, but the serial port will not
> > be detected. I had a quite long debugging session last night (adding
> > printk's to the pci code takes some time, for you have to reboot to load
> > the new kernel), and I think I found the reason:
> >
> > The card shows up on the PCI bus as one device. For the card provides
> > both serial and parallel ports, it will be driven by two subsystems, the
> > serial and the parallel driver.
> 
> Given your description, this board is certainly not a multi-fonction PCI
> device. Multi-function PCI devices provide separate resources for each
> function in a way that allows each function to be driven by separate
> software drivers. A single function PCI device that provides several
> functionnalities commonly handled by separate sub-systems, is nothing but
> a bag of shit we should not want to support in any O/S in my opinion.
> Let me claim that ingenieers that want O/Ses to support such hardware are
> either morons or bastards.

Unfortunately, Windoze supports this configuration, and that's enough
for most hardware designers.  This is also an issue with the joystick
ports on many PCI sound cards.  We're not in a position to get up on the
soap box and decree this hardware "a bag of shit" though, yet.

PS.  I have run into this issue before with joystick ports on many PCI
sound cards.  The only one that I found that did it right (seperate PCI
function for the game port) was the SBLive.

-- 

						Brian Gerst
