Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293042AbSBVXjs>; Fri, 22 Feb 2002 18:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293044AbSBVXjj>; Fri, 22 Feb 2002 18:39:39 -0500
Received: from max.hkust.se ([194.18.100.146]:34503 "EHLO max.hkust.se")
	by vger.kernel.org with ESMTP id <S293043AbSBVXj3>;
	Fri, 22 Feb 2002 18:39:29 -0500
Message-ID: <3C76D6A7.60A82BBA@hkust.se>
Date: Sat, 23 Feb 2002 00:39:19 +0100
From: Magnus Stenman <stone@hkust.se>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Seagate IDE tape problems
In-Reply-To: <mailman.1014321006.12055.linux-kernel2news@redhat.com> <200202220758.g1M7wn707473@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > I'm having trouble with a Seagate IDE tape drive that previously
> > worked with 2.2.x kernels. (tape is a STT8000A travan drive)
> >[...]
> > PIIX4: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> > hda: SAMSUNG SV2042H, ATA DISK drive
> > hdc: SAMSUNG SV3063H, ATA DISK drive
> > hdd: Seagate STT8000A, ATAPI TAPE drive
> 
> Make sure you switched DMA off with hdparm -d0.
> You must find corresponding /dev/hdX, hdparm does not work
> on /dev/ht0. If is a known problem (Red Hat bug #54517).
> 
> BTW, if you have trouble with Red Hat kernels, you may find
> better luck trying Red Hat support. What if I did not see
> your message here?

Because it was related to ide-tape (which I don't use) and
it also was about the tape not working at all or with massive amounts
of errors. Which I already know, bacause I tried it.
I now run with the SCSI emulation (scsi_mod, ide-scsi etc) and it
seems to *almost* work fine...

I'll try with DMA off and see what happens, but that should slow down
the other HDD on the bus, right?

Is there any known problems with changing the DMA settings back
and forth on a live production system?


/magnus

> 
> -- Pete
