Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265746AbUGNUHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbUGNUHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUGNUHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:07:40 -0400
Received: from adsl-65-68-136-66.dsl.stlsmo.swbell.net ([65.68.136.66]:6537
	"EHLO demigod.technicalworks.net") by vger.kernel.org with ESMTP
	id S265746AbUGNUGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:06:41 -0400
Message-ID: <011601c469de$9456f700$010a300a@drightler2k>
From: "Dwayne Rightler" <drightler@technicalogic.com>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       <linux-kernel@vger.kernel.org>
Cc: "Dhruv Matani" <dhruvbird@gmx.net>
References: <2E314DE03538984BA5634F12115B3A4E62E88D@email1.mitretek.org>
Subject: Re: DriveReady SeekComplete Error...
Date: Wed, 14 Jul 2004 15:10:11 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0113_01C469B4.A8B5C110"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Spam-DCC: :
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0113_01C469B4.A8B5C110
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

demigod:/proc/ide/hda# cat model
SAMSUNG SV2044D


lspci -vvv output is attached.  /dev/hda is attached to the VIA chipset.  I
have another hard drive /dev/hdb and a cdrom drive /dev/hdc connected to
that chipset as well and they can do DMA transfers.

The Promise controller has 2 hard drives hooked to it which can also do DMA
transfers.

Thanks,
Dwayne
----- Original Message ----- 
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Dwayne Rightler" <drightler@technicalogic.com>;
<linux-kernel@vger.kernel.org>
Cc: "Dhruv Matani" <dhruvbird@gmx.net>
Sent: Tuesday, July 13, 2004 12:23 PM
Subject: RE: DriveReady SeekComplete Error...


> Hrmm, does anyone else have that same drive or chipset you use, do they
> also experience the problem?
>
> What is the exact model of the drive and what chipset do you use?
>
> cd /proc/ide/hda ; cat model
>
> lspci -vvv # as root
>
> -----Original Message-----
> From: Dwayne Rightler [mailto:drightler@technicalogic.com]
> Sent: Tuesday, July 13, 2004 11:58 AM
> To: Piszcz, Justin Michael; linux-kernel@vger.kernel.org
> Cc: Dhruv Matani
> Subject: Re: DriveReady SeekComplete Error...
>
> The CONFIG_IDEDISK_MULTI_MODE setting makes no difference as seen below:
>
> demigod:~# uname -a
> Linux demigod 2.6.7-kexec #2 Tue Jul 13 08:31:56 CDT 2004 i686 GNU/Linux
>
> demigod:~# zgrep CONFIG_IDEDISK_MULTI_MODE /proc/config.gz
> CONFIG_IDEDISK_MULTI_MODE=y
>
> demigod:~# dmesg | grep ^hda
> hda: SAMSUNG SV2044D, ATA DISK drive
> hda: max request size: 128KiB
> hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63
> hda: DMA disabled
> hda: dma_timer_expiry: dma status == 0x61
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> DataRequest }
> hda: dma_timer_expiry: dma status == 0x61
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> DataRequest }
> hda: dma_timer_expiry: dma status == 0x61
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> DataRequest }
> hda: DMA disabled
>
> ##########################################
>
> demigod:~# uname -a
> Linux demigod 2.6.7-kexec #1 Mon Jul 5 11:30:36 CDT 2004 i686 GNU/Linux
>
> demigod:~# zgrep CONFIG_IDEDISK_MULTI_MODE /proc/config.gz
> # CONFIG_IDEDISK_MULTI_MODE is not set
>
> demigod:~# dmesg | grep ^hda
> hda: SAMSUNG SV2044D, ATA DISK drive
> hda: max request size: 128KiB
> hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63
> hda: DMA disabled
> hda: dma_timer_expiry: dma status == 0x61
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> DataRequest }
> hda: dma_timer_expiry: dma status == 0x61
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> DataRequest }
> hda: DMA disabled
> hda: dma_timer_expiry: dma status == 0x41
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> DataRequest }
> hda: dma_timer_expiry: dma status == 0x61
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete
> DataRequest }
> ----- Original Message ----- 
> From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
> To: "Dwayne Rightler" <drightler@technicalogic.com>;
> <linux-kernel@vger.kernel.org>
> Cc: "Dhruv Matani" <dhruvbird@gmx.net>
> Sent: Tuesday, July 13, 2004 7:44 AM
> Subject: RE: DriveReady SeekComplete Error...
>
>
> > <*>     Include IDE/ATA-2 DISK support
> > [*]       Use multi-mode by default
> >
> > Have you tried recompiling the kernel and checking off the second
> option
> > show above?
> >
> > CONFIG_IDEDISK_MULTI_MODE
> > If you get this error, try to say Y here:
> > hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
> > hda: set_multmode: error=0x04 { DriveStatusError }
> > If in doubt, say N.
> >
> >
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Dwayne
> Rightler
> > Sent: Tuesday, July 13, 2004 8:33 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Dhruv Matani
> > Subject: Re: DriveReady SeekComplete Error...
> >
> > I have a similar problem with a Samsung hard drive. Model SV2044D.
> The
> > output of 'hdparm -i' below indicates it supports several multiword
> and
> > ultra DMA modes but if i run the drive in anything other than PIO mode
> > it
> > gets DMA timeouts and SeekComplete Errors.  This has been on every
> > kernel I
> > can recall in the 2.4 and 2.6 series.
> >
> > demigod:~# hdparm -i /dev/hda
> >
> > /dev/hda:
> >
> >  Model=SAMSUNG SV2044D, FwRev=MM200-53, SerialNo=0228J1FN905733
> >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> >  RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
> >  BuffType=DualPortCache, BuffSize=472kB, MaxMultSect=16, MultSect=16
> >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39862368
> >  IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> >  DMA modes:  mdma0 mdma1 mdma2
> >  UDMA modes: udma0 udma1 udma2 udma3 *udma4
> >  AdvancedPM=no WriteCache=enabled
> >  Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4
> >
> >  * signifies the current active mode
> >
> >
> >
> > ----- Original Message ----- 
> > From: "Dhruv Matani" <dhruvbird@gmx.net>
> > To: <linux-kernel@vger.kernel.org>
> > Sent: Tuesday, July 13, 2004 7:30 AM
> > Subject: DriveReady SeekComplete Error...
> >
> >
> > > Hi,
> > > I've been getting this error for my brand new (2 months old) Samsung
> > > HDD. The model Number is: SV0411N, and it is a 40GB disk. I'm using
> > the
> > > kernel version 2.4.20-8 provided by RedHat. When I used
> RH-7.2(before
> > > upgrading to RH-9), the same HDD worked fine. Also, when I
> > re-installed
> > > RH-7.2, it worked fine?
> > >
> > > Any suggestions?
> > >
> > > Please cc me the reply, sine I'm not subscribed.
> > > Thanks ;-)
> > >
> > > -- 
> > >         -Dhruv Matani.
> > > http://www.geocities.com/dhruvbird/
> > >
> > > As a rule, man is a fool. When it's hot, he wants it cold.
> > > When it's cold he wants it hot. He always wants what is not.
> > > -Anon.
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

------=_NextPart_000_0113_01C469B4.A8B5C110
Content-Type: application/x-gzip;
	name="lspci-output.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci-output.gz"

H4sICAuP9UAAA2xzcGNpLW91dHB1dADtmm1T2koUgD/rrzgfdcLK5oUYndKZGKhmKpYSxDvj8CEk
G8g0L9wktNpff88GBBIBKVU6dq4jmJizJ2d3n/Oym1BK6Xn+e0LhKk4zGCS+O2Tn0DN16DJnFMVB
PPRZWgEzck6g19VkVa7iVw3uP3dFWa5+buF3H44S9h2ofHx4YE0G6WOasfAcLv2hTQaPGVvoejyH
2+hbFP+IwGXffYcB2kAPD4w4ypI4OAez+oVAi4UCXEzSlo2KEgGsMXOMRydg+aU786ZHoHepW1Ec
jwm07aSZJASsjI3HfjTEo2anQ+ATtr6QLgjalNnZJD0Hwx4LoKqtq58EbhufFiJzHY1mz2pe10Pm
+pMQPnb1QZxkBD7MD1r5gQAfp/f40MY/wuHBtZ2xyMHeaYcHHTb04wjoOTc2Th7BzoDR6Q8cyRIZ
+FkFxgnzWOaM7EHAcNjQNHvgB36Go30O9zbtg37Zhu8sSbky6QQHad6Pzte6LIGZxgT05F/rZ51i
1wL8ti50AcyubsQjApd6p6sqBK66iR2lBFQFb4x9vhO4aplAB42uP4iVBwl1G3EY2pGbKxefqyW8
zULnXNdMy4cojtjHZ91wsBvt+AdLoGVH9pCFLMoWfcK7fgrsIQq2W00j+IbDb5n4JeJHwhtOHoxJ
kmCTOg11LnPUoKSClyt4udKQR3HG/zhx4JLjpeFpUC5MmhEfW66U8U40LMcOWH167fCQPsEvIvxt
w9yVfT4uyP84iYfE9xBnuL+Jk9AOEHAndln/uEi3sAe6hdekmyzRjRBe8FuNEz+0k8c6pRVIsZuR
m5+JeDZBDa4fcSjyc+aQYNq8jq1xAGDARn7kzsebT4SKH5IfeJ53eDDzm5Kg67q5DxHXcz0vF2wv
ORGEq1sNBrNW7mDWqvkwRofgCHa+tLh3PpkA966fcl1uH+5T/yerK5/72OVclZHhBOJI+tnj0xzc
xKal55OFszobw48dlrJseX5KPqHt5hPCPn3iFH0Cu7aFT0iGqqlwr4/jIIjBmoyxX1Y8yUaznKDQ
Yk54QVNVz30xi/PbTwf+df1HePvsQDb5zzuMkKcnIpiNJvgRjrdnOy8AUdNUvXpRXUzp7ER+wEMD
2mbb4NMH0/nLNU/LB/V4EUc1G+5nAhZz2tBO/HZ/e5TQhpUmyNyE6WFtlSX7j9VF1oTXY02W5qWI
kvcGxiif8njneTadBThR7b9TJiW4tS5gNl0BSzYC8cB/4PYKYwtvJSLRi5ZT/ET7uJjGufR2yB3d
JXE0RH6OSzb9Ok7CizgJfyZ0qUoFb+OMGFz7EQML4cF49kA1XtICr/JTHCuTh4hkMs6wRvAjaECC
uYC5eUDvfIXaWiQdjT4hKUvPkdwxae4ZSfl/JP8mJJ2/AEkFrFZesv9aCacbbXNNBfc7q3qyII28
g1xamnFVew8zXoPWJMh83lkb7Inrx+BsF5FyDnTj7BSN5c3K4ai2Cwk2pdKKmLNXEn4/5pSCiFEK
ImfLuz6FIOJq3BFmF8XyRWUeYZT+XEoqS9GC1Dss1s5wOdnMRiyJWFaA8drPGPmC4xmH4STyHTtD
q1NOJFzfNEVKu/9M0ZNK6G3RcI+lPHnjUl5VnhGolwgU6VoEnQVlrudpfFb6y0gudin5tgrzlncp
ozgihZ3KmSKpxtcNqzZSFFrcSFnCwF6HwfqYpBo4lzrcd0aY4fvzdWKBhQbB9P8NrPw0R6DxqUlq
MoeHy+tvUfL8CgmvWvLAkXRWoxRhD/2oAjKfT35iPxzvUA2VMVofyBy6TNHpSxQxbQuKRElbQ5G4
niIHKbph2Y84+VaAKO9Z6gcYExK0Oo8Ii3+a1rWsnaHKduKnIVx2q9ODxoRl2ZwssUhWKZWJp46H
Jkg7PK/YGai33iXIgVri6fRVcRLF1Y9DOCIO3RhoniU619mQ6MSN+6bC6kQnYKLDjyRME50wS3TC
7onORTYtwzIhzZDAISsAqrv2OGMO6Fc6kc4Uelu9vas2oAq6aZBTTRNvV1P4rN3d9B75E7vpxTdZ
1f1JIumCSOl1iVyfJ11nOcKxFyKctxnf5ecHWwW4V8Bd2Hdd5yHuTzEytNN0JfbtJA79dHmNMEvv
EpXU0xnyUhH5tW1ugyyxxfLacv/7tK+a0l+EtraW2UGBWfUZs0VhbZvlxmBRLmoLKbksRVfpKm+h
2Avz1CWxWsmZFLqVM2G5sLM71Tat3ddnj/25kzh9DQMhRe8Jx1i+8Geay44U9Xy+pF8ub256CtbG
Zg/L55vu4i2M4qYhqiztGVrdi1m5PF0y9VgQO372CIryJ1xLeMtUImJ1M08ltadMsnvlwsovcqyj
lT+l3pRDnI1vhMwfz7R2JV7dtDHwR4kvW6ooxZddxPLLLqK6+8su5M1edjn8D1GCl9pAJQAA

------=_NextPart_000_0113_01C469B4.A8B5C110--

