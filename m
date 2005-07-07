Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVGGQkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVGGQkC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVGGQkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:40:01 -0400
Received: from web32605.mail.mud.yahoo.com ([68.142.207.232]:15182 "HELO
	web32605.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261181AbVGGQjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:39:03 -0400
Message-ID: <20050707163903.83550.qmail@web32605.mail.mud.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Thu, 7 Jul 2005 09:39:02 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Head parking (was: IBM HDAPS things are looking up)
To: Pekka Enberg <penberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f020507070638393f68d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Pekka Enberg <penberg@gmail.com> wrote:

> On 7/7/05, Martin Knoblauch <knobi@knobisoft.de> wrote:
> >  Interesting. Same Notebook, same drive. The program say "not
> parked"
> > :-( This is on FC2 with a pretty much vanilla 2.6.9 kernel.
> > 
> > [root@l15833 tmp]# hdparm -i /dev/hda
> > 
> > /dev/hda:
> > 
> >  Model=HTS726060M9AT00, FwRev=MH4OA6BA, SerialNo=MRH403M4GS88XB
> 
> haji ~ # hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=HTS726060M9AT00, FwRev=MH4OA6DA, SerialNo=MRH453M4H2A6PB

 OK, different FW levels. After upgrading my disk to MH40A6GA my head
parks :-) Minimum required level for this disk seems to be A6DA. Hope
this info is useful. 

[root@l15833 tmp]# hdparm -i /dev/hda

/dev/hda:

 Model=HTS726060M9AT00, FwRev=MH4OA6GA, SerialNo=MRH403M4GS88XB
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7877kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=117210240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:

 * signifies the current active mode

[root@l15833 tmp]# ./park /dev/hda
head parked
[root@l15833 tmp]#


Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
