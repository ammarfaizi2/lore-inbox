Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUGODxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUGODxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 23:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265903AbUGODxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 23:53:38 -0400
Received: from imap.gmx.net ([213.165.64.20]:43181 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265065AbUGODx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 23:53:28 -0400
X-Authenticated: #19232476
Subject: Re: DriveReady SeekComplete Error...
From: Dhruv Matani <dhruvbird@gmx.net>
To: Dwayne Rightler <drightler@technicalogic.com>
Cc: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <011601c469de$9456f700$010a300a@drightler2k>
References: <2E314DE03538984BA5634F12115B3A4E62E88D@email1.mitretek.org>
	 <011601c469de$9456f700$010a300a@drightler2k>
Content-Type: multipart/mixed; boundary="=-Pw/1SVuVaEjfm0DDfw2U"
Organization: 
Message-Id: <1089864451.3184.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Jul 2004 09:38:40 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Pw/1SVuVaEjfm0DDfw2U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-07-15 at 01:40, Dwayne Rightler wrote:
> demigod:/proc/ide/hda# cat model
> SAMSUNG SV2044D

I have: SAMSUNG SV0411N

> 
> 
> lspci -vvv output is attached.  /dev/hda is attached to the VIA chipset.  I
> have another hard drive /dev/hdb and a cdrom drive /dev/hdc connected to
> that chipset as well and they can do DMA transfers.
> 
> The Promise controller has 2 hard drives hooked to it which can also do DMA
> transfers.

I have attached my configuration too. The HDD is connected to the
primary master cable, and I have 2 cd-roms (One cd-writer connected to
Secondary slave), and the cd-reader connected to the secondary master
cable.

> 
> Thanks,
> Dwayne
> ----- Original Message ----- 
> From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
> To: "Dwayne Rightler" <drightler@technicalogic.com>;
> <linux-kernel@vger.kernel.org>
> Cc: "Dhruv Matani" <dhruvbird@gmx.net>
> Sent: Tuesday, July 13, 2004 12:23 PM
> Subject: RE: DriveReady SeekComplete Error...
> 
> 
> > Hrmm, does anyone else have that same drive or chipset you use, do they
> > also experience the problem?
> >
> > What is the exact model of the drive and what chipset do you use?
> >
> > cd /proc/ide/hda ; cat model
> >
> > lspci -vvv # as root
> >
> > -----Original Message-----
> > From: Dwayne Rightler [mailto:drightler@technicalogic.com]
> > Sent: Tuesday, July 13, 2004 11:58 AM
> > To: Piszcz, Justin Michael; linux-kernel@vger.kernel.org
> > Cc: Dhruv Matani
> > Subject: Re: DriveReady SeekComplete Error...
> >
> > The CONFIG_IDEDISK_MULTI_MODE setting makes no difference as seen below:
> >
> > demigod:~# uname -a
> > Linux demigod 2.6.7-kexec #2 Tue Jul 13 08:31:56 CDT 2004 i686 GNU/Linux
> >
> > demigod:~# zgrep CONFIG_IDEDISK_MULTI_MODE /proc/config.gz
> > CONFIG_IDEDISK_MULTI_MODE=y
> >
> > demigod:~# dmesg | grep ^hda
> > hda: SAMSUNG SV2044D, ATA DISK drive
> > hda: max request size: 128KiB
> > hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63
> > hda: DMA disabled
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: DMA disabled
> >
> > ##########################################
> >
> > demigod:~# uname -a
> > Linux demigod 2.6.7-kexec #1 Mon Jul 5 11:30:36 CDT 2004 i686 GNU/Linux
> >
> > demigod:~# zgrep CONFIG_IDEDISK_MULTI_MODE /proc/config.gz
> > # CONFIG_IDEDISK_MULTI_MODE is not set
> >
> > demigod:~# dmesg | grep ^hda
> > hda: SAMSUNG SV2044D, ATA DISK drive
> > hda: max request size: 128KiB
> > hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63
> > hda: DMA disabled
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: DMA disabled
> > hda: dma_timer_expiry: dma status == 0x41
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > hda: dma_timer_expiry: dma status == 0x61
> > hda: DMA timeout error
> > hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> > DataRequest }
> > ----- Original Message ----- 
> > From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
> > To: "Dwayne Rightler" <drightler@technicalogic.com>;
> > <linux-kernel@vger.kernel.org>
> > Cc: "Dhruv Matani" <dhruvbird@gmx.net>
> > Sent: Tuesday, July 13, 2004 7:44 AM
> > Subject: RE: DriveReady SeekComplete Error...
> >
> >
> > > <*>     Include IDE/ATA-2 DISK support
> > > [*]       Use multi-mode by default
> > >
> > > Have you tried recompiling the kernel and checking off the second
> > option
> > > show above?
> > >
> > > CONFIG_IDEDISK_MULTI_MODE
> > > If you get this error, try to say Y here:
> > > hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
> > > hda: set_multmode: error=0x04 { DriveStatusError }
> > > If in doubt, say N.
> > >
> > >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org
> > > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Dwayne
> > Rightler
> > > Sent: Tuesday, July 13, 2004 8:33 AM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Dhruv Matani
> > > Subject: Re: DriveReady SeekComplete Error...
> > >
> > > I have a similar problem with a Samsung hard drive. Model SV2044D.
> > The
> > > output of 'hdparm -i' below indicates it supports several multiword
> > and
> > > ultra DMA modes but if i run the drive in anything other than PIO mode
> > > it
> > > gets DMA timeouts and SeekComplete Errors.  This has been on every
> > > kernel I
> > > can recall in the 2.4 and 2.6 series.
> > >
> > > demigod:~# hdparm -i /dev/hda
> > >
> > > /dev/hda:
> > >
> > >  Model=SAMSUNG SV2044D, FwRev=MM200-53, SerialNo=0228J1FN905733
> > >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> > >  RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
> > >  BuffType=DualPortCache, BuffSize=472kB, MaxMultSect=16, MultSect=16
> > >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39862368
> > >  IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> > >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> > >  DMA modes:  mdma0 mdma1 mdma2
> > >  UDMA modes: udma0 udma1 udma2 udma3 *udma4
> > >  AdvancedPM=no WriteCache=enabled
> > >  Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4
> > >
> > >  * signifies the current active mode
> > >
> > >
> > >
> > > ----- Original Message ----- 
> > > From: "Dhruv Matani" <dhruvbird@gmx.net>
> > > To: <linux-kernel@vger.kernel.org>
> > > Sent: Tuesday, July 13, 2004 7:30 AM
> > > Subject: DriveReady SeekComplete Error...
> > >
> > >
> > > > Hi,
> > > > I've been getting this error for my brand new (2 months old) Samsung
> > > > HDD. The model Number is: SV0411N, and it is a 40GB disk. I'm using
> > > the
> > > > kernel version 2.4.20-8 provided by RedHat. When I used
> > RH-7.2(before
> > > > upgrading to RH-9), the same HDD worked fine. Also, when I
> > > re-installed
> > > > RH-7.2, it worked fine?
> > > >
> > > > Any suggestions?
> > > >
> > > > Please cc me the reply, sine I'm not subscribed.
> > > > Thanks ;-)
> > > >
> > > > -- 
> > > >         -Dhruv Matani.
> > > > http://www.geocities.com/dhruvbird/
> > > >
> > > > As a rule, man is a fool. When it's hot, he wants it cold.
> > > > When it's cold he wants it hot. He always wants what is not.
> > > > -Anon.
> > > >
> > > >
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel"
> > > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
-- 
        -Dhruv Matani.
http://www.geocities.com/dhruvbird/

As a rule, man is a fool. When it's hot, he wants it cold. 
When it's cold he wants it hot. He always wants what is not.
	-Anon.


--=-Pw/1SVuVaEjfm0DDfw2U
Content-Disposition: attachment; filename=lspci_output.gz
Content-Type: application/x-gzip; name=lspci_output.gz
Content-Transfer-Encoding: base64

H4sICLgB9kAAA2xzcGNpX291dHB1dADtWG1v4kgM/lx+hT8WpVnyUlIWtZVCoC3a0nKkZU9CfBiS
gY6azETJ0C3768+TUN6WdkFt77TSRSLMENtx/Dx2bAyjbhhfDLgSmYRRysIJrUO/7cIdDR64iMSE
0ewI2jz4Av27mu04FbdyAgM3EVEk4Nudlf9i2/awdOAJLlMR1aFdudWhQ2MNGtOsQzJJUw38hAbe
LIhoful7+6avQ//S9bkQiQ5dkrbSVAdf0iRhfIKrVq+nwwVqN6yGXjrwJZHTrA4eSTRwnM7DTw3u
mxdLkYWNZqvvt67PYhqyaQznd+5IpFKH08Wiky80OC/ucdpVX6WDayIpD2Z1MEoHPTphgoNRV86K
dAZEAjWKAw5tSx8xeQRJSsdUBg9kFNEyDDL2k545xx0VC5KQEYuYxPjV4ZQ8ERYpKRA8moEUkAoh
z0slAwEwEYCu135f/MG97A7hMEnFRGdjQC8HNyKNSQQhDURIh+V1gLQ/HKCGulWSspikszPDOIIM
H5OH+c7E3RQthIyjRrGngR4V6meojQGAEX1gPFxEXSFL8KPni/F4XDqYQ78hGI4LIui4GI9zwe4K
DyDeqhWMgxetYK7VyC95EgHByDA5e4npjWj7rqaCjyjNY3LeoxmVq/Heh2IEKeaJOJ5yFhCpmB0U
XIhoWoeeCB5/0ChCniETeC6AxLnyLqDqPEKTSFK5IM/QQR7FcJjSJzBM5JM/HWUzJE+8p4nPYKL2
JhP1NSZq+zJRf5WJtoVkUo+cThOJhGQcXAz8VNJQQdDu/QVmbXs5CZEE6+WEC65vLynfhgsbZh40
SNCtLDcTqFzP5Wr7FR5TFR5k2g6Fx7JtNxctOLsG/XatOtzzRy5+cKw/TyygYBsnxx8LvLZDCdLf
V4JeB97YN9QmtJstYIorYxK8HW2vWnPcSqOSr52aKvHFxn7GpQfddtdTcYMicLnlIi2d8vIdUCMw
mAv4NOhCN2XdYXkH7BY+bHXBVi4Uy+o2T/7998x/mt3OIjOPNzJTpfc8M01n79S04N5vgLdSpt8A
61kdcH+FXYTSUmxbahbUsOzyenugpHejw+H3VPAJYlve8Gl/qLUPLeQfmM+2dQQBCR4oRIxTUKiB
UfsF/uYG/Jb5KvyhsYDftvaG3/4f/j8c/uP3wF+FzjSSTD0QATINmVjr2N58U2N9VrVZnU7A9b7i
KTewSYljYx3+SzYh+mgm6dL0DC5d/aTv/g23fCRIGs5NHfYoiSR9BPfac6rGttlCXzJB//Sa/34m
bADtbQJtrTZx60DXFkBb1b3qvFkM3xgIBDdOsGlWUqs4+2gG93lXPUmJcsjP0cpg4DN/iF2VUbGN
qpofKzgB5raaLEsiMgM3JIl8AfursZH/KLmR/h9xs7dLwmcQ4Z1D5u+IsO1932j7d5DSDDMUG0Hr
lfZ+p38LTKvWWevtV+cDSnebD9DIyoBgbfCTLAcEFES51nNCeKZEe7ed+Z1yb2EQskwZDodrk8eu
hP4HIJMJGk4SAAA=

--=-Pw/1SVuVaEjfm0DDfw2U--

