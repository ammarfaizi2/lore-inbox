Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282918AbRK0Lib>; Tue, 27 Nov 2001 06:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRK0LiS>; Tue, 27 Nov 2001 06:38:18 -0500
Received: from sr3.terra.com.br ([200.176.3.18]:40642 "EHLO sr3.terra.com.br")
	by vger.kernel.org with ESMTP id <S282918AbRK0LiI>;
	Tue, 27 Nov 2001 06:38:08 -0500
Message-ID: <3C037B1E.1000501@terra.com.br>
Date: Tue, 27 Nov 2001 09:38:06 -0200
From: Piter Punk <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How do  I add a drive to the DMA blacklist?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valkai Elod wrote:

On Mon, 26 Nov 2001, Mark Hymers wrote:


On Sun, 25, Nov, 2001 at 06:17:08PM -0500, Jonathan Kamens spoke thus..

Actually, while this subject is being brought up, if I don't do:
/sbin/hdparm -d0 /dev/hdc
on bootup, my system locks up randomly.  Looks like a DMA issue with my
hdc drive.. Details are:

/proc/ide/hdc/model:
QUANTUM FIREBALLlct08 26


This seems to confirm my doubts about Quantum lct drives' sanity. I'm
having two drives: a Quantum CX 13G, and a Maxtor 40G@5400. Both work with
UDMA33 (mb doesn't support more). When i put a QUANTUM FIREBALL lct20 20G
drive in my rack, random lockups occur. I'd put all Quantum LCT drives on
the blacklist!

My Quantum Fireball lct20 works fine, and i work in UDMA 5, without any 
problems...

Ok, i have a problem, in Ultra 5 i can't got same performance of other (no 
cheap) HDs...

$ hdparm -i /dev/hda

/dev/hda:

Model=QUANTUM FIREBALLlct20 20, FwRev=APL.0900, SerialNo=552114732078
Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=8, MultSect=off
CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=39876480
IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4
DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
AdvancedPM=no
Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 ATA-4 
ATA-5

-- 
   ____________
  / Piter PUNK \_____________________________________________________
|                                                                   |
|      |        E-Mail: piterpk@terra.com.br         (personal)     |
|     .|.               roberto.freires@gds-corp.com (professional) |
|     /V\                                                           |
|    // \\      UIN: 116043354  Homepage: www.piterpunk.hpg.com.br  |
|   /(   )\                                                         |
|    ^`~'^         ----> Slackware Linux - The Best One! <----      |
|   #105432                                                         |
`-------------------------------------------------------------------'

