Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292529AbSCIHS6>; Sat, 9 Mar 2002 02:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292475AbSCIHRb>; Sat, 9 Mar 2002 02:17:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292482AbSCIHPK>;
	Sat, 9 Mar 2002 02:15:10 -0500
Date: Fri, 8 Mar 2002 22:58:41 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20268 spurious interrupt
Message-ID: <20020309035841.GA3758@Krystal>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020208004954.GA19421@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-3942-1015646322-0001-2"
Content-Disposition: inline
In-Reply-To: <20020208004954.GA19421@Krystal>
User-Agent: Mutt/1.3.27i
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.2.20 (i586)
X-Uptime: 22:44:58 up 38 days, 13:11,  1 user,  load average: 0.11, 0.11, 0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-3942-1015646322-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I did a little bit of testing lately, and with the 2.4.1[78] and
2.4.19-pre2-ac3 kernels the problem occurs on my asus p2b-s. I tried to
install the pdc20268 in another computer, with a VIA chipset, and I get
the same error. The interesting fact is that if I do the same test (same
hard drives) on a pdc20265 board with Ultra100 bios (onboard on the VIA
board), there is no problem at all.

Replacing the pdc20268 by another Ultra100TX2 board leads to the same probl=
em.

I believe it's related to the pdc20268 support in the kernel, but I have
no clue of where the problem can come from.

Any suggestions ?


Here is my configuration :

/proc/pci :
[cut]
  Bus  0, device  10, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20268
      (rev 1).
      IRQ 11.
      Master Capable.  Latency=3D32.  Min Gnt=3D4.Max Lat=3D18.
      I/O at 0xb800 [0xb807].
      I/O at 0xb400 [0xb403].
      I/O at 0xb000 [0xb007].
      I/O at 0xa800 [0xa803].
      I/O at 0xa400 [0xa40f].
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe0803fff].
[cut]

dmesg :
[cut]
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
PDC20268: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 11 for device 00:0a.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio,
hdf:pio
ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio,
hdh:pio
hde: WDC WD400BB-53AUA1, ATA DISK drive
hdg: MAXTOR 6L040J2, ATA DISK drive
ide2 at 0xb800-0xb807,0xb402 on irq 11
ide3 at 0xb000-0xb007,0xa802 on irq 11
hde: 78165360 sectors (40021 MB) w/2048KiB Cache,
CHS=3D77545/16/63, UDMA(100)
hdg: 78177792 sectors (40027 MB) w/1818KiB Cache,
CHS=3D77557/16/63, UDMA(100)
[cut]


* Mathieu Desnoyers (compudj@krystal.dyndns.org) wrote:
> I have a problem here since I plugged my second hard disk on my Promise
> Ultra 100 TX2 PDC20268 controller. It occurs all the time when I use soft=
ware
> raid 0. I looked at the LKML archives, and this problem does not seems to=
 be
> solved. There is a simpler way to generate the problem than to use raid.
>=20
> It occurs when I use dd for reading on my both hard disks in parallel.
> The disks are both masters of their channel.
>=20
> When I do this test, The message I get is=20
>=20
> spurious 8259A interrupt: IRQ7.
> spurious 8259A interrupt: IRQ15.
>=20
> And I can look at /proc/interrupts and see the ERR counter increment at
> a phenomenal speed.
>=20
> I wonder if this problem is due to the linux driver support or if it is
> a hardware bug.
>=20
>=20
> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compu=
dj.gpg
> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=
=20


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-3942-1015646322-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8iYhxPyWo/juummgRArR4AKCIKnU62JFWPbApK1bUubQDUTXrnwCfesja
+YOG9IkWHSs+sDSzQHtwCFg=
=x2Do
-----END PGP SIGNATURE-----

--=_Krystal-3942-1015646322-0001-2--
