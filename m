Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUELQwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUELQwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUELQwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:52:13 -0400
Received: from smtp4.poczta.onet.pl ([213.180.130.28]:63407 "EHLO
	smtp4.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S265124AbUELQwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:52:09 -0400
From: Marcin Garski <garski@poczta.onet.pl>
Reply-To: garski@poczta.onet.pl
To: linux-kernel@vger.kernel.org
Subject: Re: SiI3112 Serial ATA - no response on boot
Date: Wed, 12 May 2004 18:51:42 +0200
User-Agent: KMail/1.6.2
References: <200405112052.44979.garski@poczta.onet.pl> <40A12409.40808@dotnetitalia.it>
In-Reply-To: <40A12409.40808@dotnetitalia.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405121851.42401.garski@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, I am not subscribed to the list, thanks]

Marco Adurno wrote:
> I've got the same problem some time ago.
> You have just to appen the string
> hdg=none
> in your boot loader config file

Thanks, that's working.
But isn't that a workaround for problem with probe (on NON SATA HDD 
probe don't generate such errors) that should be fixed somehow?

> Marcin Garski wrote:
> > 
> > Hi,
> >
> > I have a Abit NF7-S V2.0 mainboard (nForce2 chipset + SiI3112
> > SATA), with Seagate S-ATA connected to Sil3112.
> >
> > During boot i get following messages:
> > SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
> > SiI3112 Serial ATA: chipset revision 2
> > SiI3112 Serial ATA: 100% native mode on irq 11
> >     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
> >     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
> > hde: ST380013AS, ATA DISK drive
> > ide2 at 0xe083c080-0xe083c087,0xe083c08a on irq 11
> > hdg: no response (status = 0xfe)
> > hdg: no response (status = 0xfe), resetting drive
> > hdg: no response (status = 0xfe)
> >
> > Each "no response" message delays booting about 20 seconds.
> > I don't have any device connected to hdg.
> > I was wondering how to speed up booting, because this "hdg: no
> > response (status = 0xfe), resetting drive" info is little
> > irritating? I'm running on 2.6.6 kernel (on 2.6.4 this "no
> > response" messages also appear).

-- 
Best Regards
Marcin Garski
