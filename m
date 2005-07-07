Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVGGNPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVGGNPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVGGNPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:15:11 -0400
Received: from web32602.mail.mud.yahoo.com ([68.142.207.229]:34226 "HELO
	web32602.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261462AbVGGNNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:13:35 -0400
Message-ID: <20050707131331.12406.qmail@web32602.mail.mud.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Thu, 7 Jul 2005 06:13:31 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Head parking (was: IBM HDAPS things are looking up)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Pekka Enberg wrote:
> Jens Axboe wrote:
> > > ATA7 defines a park maneuvre, I don't know how well supported it
is
> > > yet though. You can test with this little app, if it says 'head
> > > parked' it works. If not, it has just idled the drive.
>
> On 7/7/05, Lenz Grimmer <lenz@xxxxxxxxxxx> wrote:
> > Great! Thanks for digging this up - it works on my T42, using a
Fujitsu
> > MHT2080AH drive:
>
> Works on my T42p which uses a Hitachi HTS726060M9AT00 drive. I don't
> hear any sound, though.

 Interesting. Same Notebook, same drive. The program say "not parked"
:-( This is on FC2 with a pretty much vanilla 2.6.9 kernel.

[root@l15833 tmp]# uname -a
Linux l15833 2.6.9-noagp #1 Wed May 4 16:09:14 CEST 2005 i686 i686 i386
GNU/Linux
[root@l15833 tmp]# hdparm -i /dev/hda

/dev/hda:

 Model=HTS726060M9AT00, FwRev=MH4OA6BA, SerialNo=MRH403M4GS88XB
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
head not parked 4c
[root@l15833 tmp]#

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
