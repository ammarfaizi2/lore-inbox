Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTGBOhC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTGBOhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:37:02 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:53008 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265030AbTGBOg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:36:57 -0400
Date: Wed, 2 Jul 2003 16:12:04 +0200
From: DervishD <raul@pleyades.net>
To: Jens Axboe <axboe@suse.de>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slow writer...
Message-ID: <20030702141204.GA314@DervishD>
References: <20030701213036.GB239@DervishD> <20030702111708.GB839@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030702111708.GB839@suse.de>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jens, and thanks a lot for answering :)

 * Jens Axboe <axboe@suse.de> dixit:
> - Is the cd writer on a different channel?

    Yes, the hard disk is primary master, the writer secondary
master.

> - What ide adapter are you using?

    The VP_IDE, with a VIA 82c686b chipset.

> - Is dma enabled on the cd writer?

    Yes, if I use the IDE-CD driver, hdparm reports that the writer
is UDMA2 capable

cd:

 Model=PLEXTOR CD-R PREMIUM, FwRev=1.00, SerialNo=013347
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no

> - What cdrecord version are you using?

    2.00. Latest is 2.00.3, although I don't know if it is stable,
I've seen it this morning.
 
> You should try 2.5.73 as well and see if it makes any difference. Make
> sure to use -dev=/dev/hdc (or whatever your cd-rw drive is) and _don't_
> use ide-scsi (just ide-cd)

    Currently I have a DIY linux box, and I'm not sure if I can test
a 2.5 kernel without updating lots of software. I've tested with
2.4.18 (which AFAIK has another IDE driver) and the same happens. I
think that maybe the motherboard is damaged :((

    I'll try the newer cdrecord (if it is stable) and, if that
doesn't work, I may consider testing 2.5

    Thanks for your answer :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
