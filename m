Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUBDViN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUBDViF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:38:05 -0500
Received: from mail01.hansenet.de ([213.191.73.61]:63123 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S266607AbUBDVfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:35:40 -0500
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: sschu@tzi.de, linux-kernel@vger.kernel.org
Subject: Re: DMA BadCRC, cables exchanged, problem resists, any idea?
Date: Wed, 4 Feb 2004 22:35:14 +0100
User-Agent: KMail/1.6
References: <20040204211338.GA31768@x20.informatik.uni-bremen.de>
In-Reply-To: <20040204211338.GA31768@x20.informatik.uni-bremen.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_aWWIAi/vyfY7GfG";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402042235.22101.MalteSch@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_aWWIAi/vyfY7GfG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I hab a similar problem on other hardware. It went away after setting the=20
(udma5-)hd to udma4 with hdparm.

On Wednesday 04 February 2004 22:13, Sven Schumacher wrote:
> Hello,
>
> I got the following error for 3 of my 4 harddrives:
>
> hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> hdf: DMA disabled
> ide2: reset: success
> hdg: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hdg: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> hdg: dma_timer_expiry: dma status =3D=3D 0x20
> hdg: timeout waiting for DMA
>
> and so on. First I used round IDE-Cables, 80c Ribbon, now I use
> flat 80c Ribbon. I tried with an CMD680-IDE-offboad-Controller and
> the onboard Promise PDC20276. Both show the same effect. The
> onboard-VIA VT 8233 (used for hda) never shows this error.
>
> cat /proc/interrupts:
>            CPU0
>   0:    1264293    IO-APIC-edge  timer
>   1:      23806    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   8:          4    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:      10688    IO-APIC-edge  PS/2 Mouse
>  14:      14589    IO-APIC-edge  ide0
>  15:         97    IO-APIC-edge  ide1
>  16:        449   IO-APIC-level  ide2, ide3
>  17:       9142   IO-APIC-level  eth0
>  21:          0   IO-APIC-level  ehci_hcd, usb-uhci
> NMI:          0
> LOC:    1264212
> ERR:          0
> MIS:          0
>
> IRQ 16 is the CMD680, ide0 and ide1 is the onboard VIA VT8235.
> The machine acts as a fileserver, so it's worse falling back to
> PIO instead of DMA. The Mainboard is an MSI-Tech KT3 Ultra 2 with
> an VIA KT 333 Chipset (Athlon 1800 XP).
> For testing purposes I tried the CMD680 in an Intel P4-based
> Computer (same cables) but none of these nasty errors! The P4 was
> running a 2.4.23 and the Athlon a 2.4.23.
>
> Used harddrives:
>
> /dev/hda:
>  multcount    =3D 16 (on)
>  IO_support   =3D  1 (32-bit)
>  unmaskirq    =3D  1 (on)
>  using_dma    =3D  1 (on)
>  keepsettings =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D  8 (on)
>  geometry     =3D 1232/255/63, sectors =3D 19807200, start =3D 0
>
>  Model=3DIBM-DTTA-351010, FwRev=3DT56OA73A, SerialNo=3DWF0WF036521
>  Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D34
>  BuffType=3DDualPortCache, BuffSize=3D466kB, MaxMultSect=3D16, MultSect=
=3D16
>  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D19807200
>  IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2
>  AdvancedPM=3Dno WriteCache=3Denabled
>  Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4
>
> /dev/hde:
>  multcount    =3D 16 (on)
>  IO_support   =3D  0 (default 16-bit)
>  unmaskirq    =3D  1 (on)
>  using_dma    =3D  1 (on)
>  keepsettings =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D  8 (on)
>  geometry     =3D 36024/16/63, sectors =3D 234493056, start =3D 0
>
>  Model=3DSAMSUNG SV1204H, FwRev=3DRK100-15, SerialNo=3D0450J1BW401217
>  Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=3D16383/16/63, TrkSize=3D34902, SectSize=3D554, ECCbytes=3D4
>  BuffType=3DDualPortCache, BuffSize=3D2048kB, MaxMultSect=3D16, MultSect=
=3D16
>  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D2344930=
56
>  IORDY=3Dyes, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5
>  AdvancedPM=3Dno WriteCache=3Denabled
>  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 1:
>
> /dev/hdf:
>  multcount    =3D 16 (on)
>  IO_support   =3D  0 (default 16-bit)
>  unmaskirq    =3D  1 (on)
>  using_dma    =3D  0 (off)
>  keepsettings =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D  8 (on)
>  geometry     =3D 41608/16/63, sectors =3D 240121728, start =3D 0
>
>  Model=3DMaxtor 6Y120L0, FwRev=3DYAR41BW0, SerialNo=3DY3K7N66E
>  Config=3D{ Fixed }
>  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D57
>  BuffType=3DDualPortCache, BuffSize=3D2048kB, MaxMultSect=3D16, MultSect=
=3D16
>  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D2401217=
28
>  IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>  AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
>  Drive conforms to: (null):
>
> /dev/hdg:
>  multcount    =3D  0 (off)
>  IO_support   =3D  0 (default 16-bit)
>  unmaskirq    =3D  0 (off)
>  using_dma    =3D  1 (on)
>  keepsettings =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D  8 (on)
>  geometry     =3D 19929/255/63, sectors =3D 320173056, start =3D 0
>
>  Model=3DMaxtor 6Y160P0, FwRev=3DYAR41BW0, SerialNo=3DY42BANHE
>  Config=3D{ Fixed }
>  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D57
>  BuffType=3DDualPortCache, BuffSize=3D7936kB, MaxMultSect=3D16, MultSect=
=3Doff
>  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D2684354=
55
>  IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>  AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
>  Drive conforms to: (null):
>
> Any ideas, what I can change to get rid of these errors?
>
> TIA Sven
>
> (please CC)

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--Boundary-02=_aWWIAi/vyfY7GfG
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAIWWZ4q3E2oMjYtURAv8dAKCW/lb2UVxuJZ6KrMNIEEKSoGWSGgCgyD2O
+A6nlCW3Tf1BsD6JjECzgg0=
=9q8o
-----END PGP SIGNATURE-----

--Boundary-02=_aWWIAi/vyfY7GfG--
