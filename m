Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbQLUPOH>; Thu, 21 Dec 2000 10:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbQLUPN5>; Thu, 21 Dec 2000 10:13:57 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:11782 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S130281AbQLUPNt>; Thu, 21 Dec 2000 10:13:49 -0500
Date: Thu, 21 Dec 2000 15:42:01 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: AMD-Viper & Maxtor 91536U6 dieing
Message-ID: <20001221154201.Q2157@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andre Hedrick <andre@linux-ide.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="w1A23YewkF9s+fLd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w1A23YewkF9s+fLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

I wonder if you know anything about a issues with AMD-Irongate IDE
controller and a Maxtor IDE disk?

Here's what happens: The thing runs fine in (hdparm -d1 -m8 -c1) mode,
giving good performance and no problems for some time (something like
some days, a week, a month).
Then, suddenly, during disk activity, the hard disk access stops.
Linux is running fine, but as there is no more HD access possible,
more and more processes start hanging.

The strange thing: When rebooting using the reset button, the BIOS
can not find the hard disk. You may press reset as often as you want
to no avail.
After a power cycle, everything is back to normal, again.

This happened a couple of times now, already.
I did not catch any syslog messages, unfortunately, but I'll configure
syslog to log over the network, so the next time, I may have something.

I suspect the drive's firmware or the AMD IDE chipset driver.

Any ideas?

Some data:
Kernel 2.2.16.SuSE (w/ your IDE patches ide.2.2.16.20000711-2-lvm)
AMD Irongate mainboard (Asus K7M), Athlon-600, 256MB.

 * linux/drivers/ide/amd7409.c          Version 0.03    Feb. 10, 2000

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (re=
v 03) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
	I/O ports at f000

 Model=3DMaxtor 91536U6, FwRev=3DVA510PF0, SerialNo=3DW605BV5A
 Config=3D{ Fixed }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D57
 BuffType=3D3(DualPortCache), BuffSize=3D2048kB, MaxMultSect=3D16, MultSect=
=3D8
 DblWordIO=3Dno, OldPIO=3D2, DMA=3Dyes, OldDMA=3D0
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D30000096
 tDMA=3D{min:120,rec:120}, DMA modes: mword0 mword1 mword2=20
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, PIO modes: mode3 mode4=20
 UDMA modes: mode0 mode1 *mode2 mode3 mode4=20
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA=
-4 ATA-5

root@gum03:/usr/src/linux-2.2.16.SuSE/drivers/block # cat /proc/ide/ide0/co=
nfig=20
pci bus 00 device 39 vid 1022 did 7409 channel 0
22 10 09 74 05 00 00 02 03 8a 01 01 00 20 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
03 00 00 00 00 00 00 00 a8 20 a8 20 ff 00 ff ff
03 00 03 40 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations <k.garloff@phys.tue.nl>   [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--w1A23YewkF9s+fLd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Qha5xmLh6hyYd04RAsXQAJ9lMpvCttc7NScz/zQA1KEDF6ZpEACdEQOO
lJKoetK4qkFCZvMgP713rTc=
=iPDm
-----END PGP SIGNATURE-----

--w1A23YewkF9s+fLd--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
