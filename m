Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317842AbSHHS03>; Thu, 8 Aug 2002 14:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317844AbSHHS03>; Thu, 8 Aug 2002 14:26:29 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:59656 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317842AbSHHS01>;
	Thu, 8 Aug 2002 14:26:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linux-ide.org>
Date: Thu, 8 Aug 2002 20:29:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Part 2: Re: [PATCH] pdc20265 problem.
CC: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
X-mailer: Pegasus Mail v3.50
Message-ID: <172AF2F5BB8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Aug 02 at 10:41, Andre Hedrick wrote:

> ide0 at 0xdfe0-0xdfe7,0xdfae on irq 31
> ide1 at 0xdfa0-0xdfa7,0xdfaa on irq 31
> ide2 at 0x1f0-0x1f7,0x3f6 on irq 14

This is definitely bug. It should assigned ide0 to the port
in legacy mode, as far as I can tell.
 
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> PIIX4: device disabled (BIOS)
> hda: DupliDisk IDE RAID-1 Adapter( 1.19), ATA DISK drive
> hdc: QUANTUM FIREBALLP KA13.6, ATA DISK drive
> ide2: ports already in use, skipping probe
> ide0 at 0xd800-0xd807,0xdc02 on irq 18
> ide1 at 0xe400-0xe407,0xe802 on irq 18

You have disabled PIIX4 here, so ide0/1 were not reserved. I assume
that if you enable PIIX4, it will use legacy ports, and will become
ide0/1.
                                            Petr Vandrovec
                                            
