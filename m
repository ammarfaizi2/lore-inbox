Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSHHQpZ>; Thu, 8 Aug 2002 12:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSHHQpZ>; Thu, 8 Aug 2002 12:45:25 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:33543 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317637AbSHHQpY>;
	Thu, 8 Aug 2002 12:45:24 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linux-ide.org>
Date: Thu, 8 Aug 2002 18:48:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] pdc20265 problem.
CC: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
X-mailer: Pegasus Mail v3.50
Message-ID: <170FF7412A6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Aug 02 at 6:02, Andre Hedrick wrote:
> 
> There are mainboard out there designed specifically to boot off the third
> party host.  I have one with the pdc20265 on it.  So if you mainboard is

Vendor + motherboard name, please.

> produced by some lame OEM who is trying to grant first access to the addon
> host chip by playing silly devfn/bus ordering games you get what you
> bought.  Yeah there are cheesy crap-mainboard oem's that play this game.

Uhh? Changing boot order in the BIOS must NOT change what ide0 is.

What are you smoking? It would completely screw my system that if I
decide to boot from secondary channel, it magically becomes ide0. If
Linux would behave this way, I could never tell which disk will get which
name until I boot. What if I boot from floppy? Then IDE interfaces will 
become numbered from ide1, because of there was no IDE boot device?
Should we also swap hda with hdb if I boot my system from primary slave?

And I did not found anything about ide0 in documents you provided.

And BTW, my board is A7V from Asus. Manual refers to VIA interface
as 'primary/secondary channels', and to PDC as 'UDMA100 interface'(s).
And PDC is always run in the native mode, IRQ14/15 is not wired to the
PDC chip at all.

I always thought that if there is IDE interface at the 0x1F0 in the
system, it will become ide0, and if there is interface at the 0x170,
it will become ide1 (and simillary for ISA-based tertiary/quaterniary). 
After this step unused ide* interfaces are populated with native PCI IDE 
interfaces, starting at ide0, and going up...
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
