Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132612AbRC1XRr>; Wed, 28 Mar 2001 18:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132609AbRC1XRi>; Wed, 28 Mar 2001 18:17:38 -0500
Received: from cafebleu.nac.net ([209.123.64.43]:20228 "EHLO
	moat3225.research.att.com") by vger.kernel.org with ESMTP
	id <S132612AbRC1XRa>; Wed, 28 Mar 2001 18:17:30 -0500
Date: Wed, 28 Mar 2001 18:15:27 -0500 (EST)
From: <dsen@homemail.com>
To: Tim Wright <timw@splhi.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE and APM (standby) incompatibility on thinkpad T21?
In-Reply-To: <20010328121719.B3059@kochanski>
Message-ID: <Pine.LNX.4.30.0103281813020.1200-100000@moat3225.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope, thats not it....my kernel already has that set. Here are the
relevant lines from /usr/src/linux/.config:

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

On Wed, 28 Mar 2001, Tim Wright wrote:

> Rebuild your kernel and make sure CONFIG_APM_ALLOW_INTS is set to "Y".
>
> Tim
>
> On Wed, Mar 28, 2001 at 12:52:05PM -0500, D. Sen wrote:
> > Attempting to 'standby' the machine generates the following
> > syslog messages:
> >
> > Mar 27 23:58:56 localhost kernel: ide_dmaproc: chipset supported
> > ide_dma_lostirq func only: 13
> > Mar 27 23:58:56 localhost kernel: hda: lost interrupt
> >
> > This seems to corrupt the filesystem..
> >
> > Kernel: 2.4.2
> >
> > hdparm -i /dev/hda:
> > /dev/hda:
> >  multcount    = 16 (on)
> >  I/O support  =  1 (32-bit)
> >  unmaskirq    =  1 (on)
> >  using_dma    =  1 (on)
> >  keepsettings =  1 (on)
> >  nowerr       =  0 (off)
> >  readonly     =  0 (off)
> >  readahead    =  8 (on)
> >  geometry     = 4134/240/63, sectors = 62506080, start = 0
> >
> >  Model=IBM-DJSA-232, FwRev=JS8IAD1A, SerialNo=48YBWLA6226
> >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> >  RawCHS=16383/15/63, TrkSize=0, SectSize=0, ECCbytes=4
> >  BuffType=DualPortCache, BuffSize=1874kB, MaxMultSect=16, MultSect=16
> >  CurCHS=16383/15/63, CurSects=1011810540, LBA=yes, LBAsects=62506080
> >  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes: pio0 pio1 pio2 pio3 pio4
> >  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
> >  AdvancedPM=yes: mode=0x9F (159)
> >  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4
> > ATA-5
> >
> > Please CC any responses to dsen@homemail.com
> >
> > DS
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
> IBM Linux Technology Center, Beaverton, Oregon
> Interested in Linux scalability ? Look at http://lse.sourceforge.net/
> "Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
>

