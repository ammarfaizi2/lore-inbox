Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDBZN>; Fri, 3 Nov 2000 20:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKDBZE>; Fri, 3 Nov 2000 20:25:04 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63751 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129033AbQKDBYv>;
	Fri, 3 Nov 2000 20:24:51 -0500
Message-ID: <3A036539.57B741C6@mandrakesoft.com>
Date: Fri, 03 Nov 2000 20:24:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Ford <david@linux.com>, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rqz1-00046G-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Not unless it was fixed in test10 release.  I have a PC LinkSys dual 10/100 and
> > > 56K card that will kill the machine if you physically pull it out no matter what
> > > cardctl/module steps are taken.
> > >
> > > It uses the ne2k and serial drivers.
> >
> > Part of that might be that serial doesn't support hotplug without
> > patching.
> 
> Linksys rings a bell with an outstandng 2.2 lockup on pcmcia. I think this might
> be a driver bug ?

On 2.2.x, possibly.

On 2.4.x:  1) insert CardBus serial or modem card, that reports itself
as PCI_CLASS_COMMUNICATION_SERIAL.  2) modprobe serial, it sees and
registers the PCI serial port.  3) eject card, which serial.c doesn't
presently notice.  ...

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
