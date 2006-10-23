Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWJWIN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWJWIN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWJWIN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:13:58 -0400
Received: from lug-owl.de ([195.71.106.12]:56972 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751798AbWJWIN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:13:56 -0400
Date: Mon, 23 Oct 2006 10:13:54 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.com, adilger@clusterfs.com, linux-ext4@vger.kernel.org
Subject: Re: 2.6.18-mm2: ext3 BUG?
Message-ID: <20061023081354.GK26271@lug-owl.de>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@osdl.org>, Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sct@redhat.com, adilger@clusterfs.com, linux-ext4@vger.kernel.org
References: <45257A6C.3060804@gmail.com> <20061005145042.fd62289a.akpm@osdl.org> <4525925C.6060807@gmail.com> <20061005171428.636c087c.akpm@osdl.org> <20061008063330.GA30283@lug-owl.de> <20061010070933.GE30283@lug-owl.de> <20061011104201.GD6865@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3qYtBtpdm1/OJWPn"
Content-Disposition: inline
In-Reply-To: <20061011104201.GD6865@atrey.karlin.mff.cuni.cz>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3qYtBtpdm1/OJWPn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-11 12:42:02 +0200, Jan Kara <jack@suse.cz> wrote:
> > On Sun, 2006-10-08 08:33:30 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de=
> wrote:
> > While I could reproduce it with a 200MB file, it seems I can't break
> > it with a 10MB file.
>   Hmm, I was running the test for several ours without any problem...
> The kernel is 2.6.17.6, ext3 in ordered data mode, standard SATA disk. I'm
> now running it again and trying my luck ;). What is your testing environm=
ent?

kolbe34-backup:/mnt# uname -a
Linux kolbe34-backup 2.6.17-2-686 #1 SMP Wed Sep 13 16:34:10 UTC 2006 i686 =
GNU/Linux
kolbe34-backup:/mnt# cat /proc/cpuinfo=20
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 448.674
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov =
pat pse36 mmx fxsr sse up
bogomips        : 898.38
kolbe34-backup:/mnt# grep -i preem /boot/config-2.6.17-2-686=20
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set
kolbe34-backup:/mnt# lspci=20
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bri=
dge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridg=
e (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0e.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 L=
ANCE] (rev 16)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/=
2X (rev 5c)
kolbe34-backup:/mnt# lspci -n
00:00.0 0600: 8086:7190 (rev 03)
00:01.0 0604: 8086:7191 (rev 03)
00:07.0 0601: 8086:7110 (rev 02)
00:07.1 0101: 8086:7111 (rev 01)
00:07.2 0c03: 8086:7112 (rev 01)
00:07.3 0680: 8086:7113 (rev 02)
00:0e.0 0200: 1022:2000 (rev 16)
01:00.0 0300: 1002:4742 (rev 5c)
kolbe34-backup:~# hdparm -i /dev/hdb

/dev/hdb:

 Model=3DST3300822A, FwRev=3D3.AAE, SerialNo=3D5NF24YCN
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D4
 BuffType=3Dunknown, BuffSize=3D8192kB, MaxMultSect=3D16, MultSect=3Doff
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D268435455
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4=20
 DMA modes:  mdma0 mdma1 mdma2=20
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5=20
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3 ATA/A=
TAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

 * signifies the current active mode


Still running Debian's 2.6.17-2-686, I'm now tracking down the file
size when I start to see this type of corruption. Right now, it seems
I never get it with a 16384 KB (16 MB) large file, but I get it with a
21504 KB (21 MB) file.

Is there something important that changes handling of file contents in
the 16..21 MB range?

dumpe2fs output at http://lug-owl.de/~jbglaw/ext3-dumpe2fs.txt for
that filesystem.  I'll now run with a 18.5 MB file...

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                           Wenn ich wach bin, tr=C3=A4ume ic=
h.
  the second  :

--3qYtBtpdm1/OJWPn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFPHnCHb1edYOZ4bsRAutSAJsEbzQEyQKRBSiz3y8JrkHySMfRcwCfUwAt
WCjUFS9/w2IBdLeZanIM99g=
=cSaT
-----END PGP SIGNATURE-----

--3qYtBtpdm1/OJWPn--
