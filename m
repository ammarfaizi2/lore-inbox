Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbRGQXHB>; Tue, 17 Jul 2001 19:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267554AbRGQXGw>; Tue, 17 Jul 2001 19:06:52 -0400
Received: from hs2-108.magma.ca ([64.26.169.108]:436 "EHLO
	mokona.furryterror.org") by vger.kernel.org with ESMTP
	id <S267559AbRGQXGe>; Tue, 17 Jul 2001 19:06:34 -0400
Date: Tue, 17 Jul 2001 19:06:22 -0400
From: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise FastTrack 100 TX2 PCI device ID's
Message-ID: <20010717190622.A10056@furryterror.org>
In-Reply-To: <E15MMMs-0007nj-00@sana.furryterror.org> <Pine.LNX.4.10.10107162342210.3343-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10107162342210.3343-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Jul 16, 2001 at 11:45:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 16, 2001 at 11:45:26PM -0700, Andre Hedrick wrote:
> That is a differnet beast.
> Did it work if so how well?

It has been filling up a 72-gig RAID0 array for ...

root@kasumi:~# uptime
  6:54pm  up 20:37,  5 users,  load average: 2.14, 2.20, 2.82

... a little over 20.5 hours now.  'hdparm -I' gives me:

root@kasumi:~# for x in e f g h; do hdparm -I /dev/hd$x; done

/dev/hde:

 Model=TS9341A0                                , FwRev=482106  , SerialNo=YA116790
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=38430, SectSize=610, ECCbytes=4
 BuffType=DualPortCache, BuffSize=448kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=17803440
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2

/dev/hdf:

 Model=DW CCA244000 D                          , FwRev=5JO83AK0, SerialNo=DWW-6T26003823 4
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=1966kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39876480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

/dev/hdg:

 Model=BI-MPDAT3-2750 0                        , FwRev=7PO63AA0, SerialNo=        J YMMJ9H6048
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=1961kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40088160
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4

/dev/hdh:

 Model=DW CCA244000 D                          , FwRev=5JO83AK0, SerialNo=DWW-6T26007867 4
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=1966kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39876480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

There's an old SCSI disk in the array too, just for some variety.  ;-)

If it ever stops working for reasons other than verifiable hardware
failure, I assure you that you'll be the second person to hear about it.
;-)

> Send 'lspci -bxxxzz > 20268.fttk.pci'  just for kicks.

My lspci doesn't understand the -z or -zz options, but 'lspci -bxxx' says:

root@kasumi:~# lspci -bxxx
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 01)
00: 86 80 50 12 06 01 00 22 01 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 09 00 41 14 00 00 10 03 49 10 11 11 11 01 11 11
60: 08 10 18 18 18 18 18 18 03 00 00 00 00 00 00 00
70: 20 00 0a 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 11 ff 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 18 0f 00 00 00 00 00 00

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00: 86 80 00 70 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 09 00 63 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 80 0b 0c 09 00 00 00 00 00 f2 00 00 00 00 00 00
70: 0f 00 00 00 00 00 0c 0c 02 00 00 00 00 00 00 00
80: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 00 80 00 02 01 00 20 0f 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 0f 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00: 86 80 10 70 05 00 80 02 00 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 80 00 80 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 10 0f 00 00 00 00 00 00

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
00: ec 10 39 81 07 00 80 02 10 00 00 02 00 40 00 00
10: 01 e0 00 00 00 00 00 fb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 RAID bus controller: Promise Technology, Inc.: Unknown device 6268 (rev 01)
00: 5a 10 68 62 07 00 30 04 01 85 04 01 08 00 00 00
10: 01 d8 00 00 01 d4 00 00 01 d0 00 00 01 c8 00 00
20: 01 c4 00 00 00 00 80 fa 00 00 00 00 5a 10 68 4d
30: 00 00 00 00 60 00 00 00 00 00 00 00 0c 01 04 12
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 01 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 (rev 02)
00: 00 10 01 00 07 00 00 02 02 00 00 01 00 40 00 00
10: 01 c0 00 00 00 00 00 fa 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: da 00 00 13 47 08 01 1f 35 00 81 00 80 00 0f 02
90: ff b8 fa 05 00 ff ff ff 00 f0 35 20 68 81 fa 05
a0: 00 08 00 a0 00 00 00 50 c4 a3 fa 05 c4 a3 fa 05
b0: 00 a0 fa 05 08 00 00 00 c8 7d 00 01 c4 43 f5 05
c0: 8f 05 00 00 7f 00 00 0f 0c 00 80 00 06 00 00 80
d0: 00 00 ff ff a3 ff ff ff 00 00 ff ff 00 41 00 00
e0: a0 08 fa 05 00 00 00 05 0c a4 fa 05 ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

00:0c.0 VGA compatible controller: ATI Technologies Inc 210888GX [Mach64 GX] (rev 01)
00: 02 10 58 47 a3 00 00 02 01 00 00 03 00 00 00 00
10: 00 00 80 f9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7VMTugfmLGlazG5wRAsfWAKCw+NsZxdHSqlKUtMlotzy0/aig7wCfakw2
pRZLlMoukiDdbopvGiw/qiE=
=Ero8
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
