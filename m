Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291446AbSBXVki>; Sun, 24 Feb 2002 16:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBXVk2>; Sun, 24 Feb 2002 16:40:28 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:50180 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S290184AbSBXVkJ>; Sun, 24 Feb 2002 16:40:09 -0500
Date: Sun, 24 Feb 2002 22:40:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224224007.A1949@ucw.cz>
In-Reply-To: <3C794DC0.7040706@evision-ventures.com> <E16f5z8-0002id-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16f5z8-0002id-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 24, 2002 at 09:15:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 09:15:06PM +0000, Alan Cox wrote:

> > The previous code didn't distinguish the bus speed between different
> > busses and it doesn't do now as well.
> > It could be really helpfull to look at the patch actually. Don't you
> > think?
> 
> I know what would actually help here, (the other code wasn't broken IMHO)
> and would clean this up properly for not just IDE. Add a bus_speed field
> to the struct pci_bus - that is where the info belongs and its the platform
> specific bus code that can find the bus speed out (if anyone)

I have some experimental IDE based code which can detect the PCI bus
speed by doing some IDE transfers and measuring the time it takes. It
isn't 100% reliable, though. I haven't found any other way to detect PCI
clock reliably, unfortunately it cannot be safely guessed from the CPU
clock or FSB clock or anything.

-- 
Vojtech Pavlik
SuSE Labs
