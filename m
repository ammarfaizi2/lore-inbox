Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277347AbRJEK7y>; Fri, 5 Oct 2001 06:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277348AbRJEK7o>; Fri, 5 Oct 2001 06:59:44 -0400
Received: from hastur.andastra.de ([212.172.44.2]:30982 "HELO mail.andastra.de")
	by vger.kernel.org with SMTP id <S277347AbRJEK7c>;
	Fri, 5 Oct 2001 06:59:32 -0400
Date: Fri, 5 Oct 2001 13:00:19 +0200
From: Sebastian Benoit <ben-lists@andastra.de>
To: linux-kernel@vger.kernel.org
Subject: Local APIC compiler error in 2.4.11-pre4
Message-ID: <20011005130019.F6433@smtp.andastra.de>
Mail-Followup-To: Sebastian Benoit <ben-lists@andastra.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Cthulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


When doing 'make oldconfig' for 2.4.11-pre4 it asked me for
"Local APIC support on uniprocessors" and I said [Y]es, why not.
see result below...


gcc -D__KERNEL__ -I/opt/home/benoit/src/linux-2.4.11-pre4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
--fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
--march=3Di686 -c -o pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input}:1050: Warning: indirect lcall without *'
{standard input}:1135: Warning: indirect lcall without *'
{standard input}:1221: Warning: indirect lcall without *'
{standard input}:1296: Warning: indirect lcall without *'
{standard input}:1307: Warning: indirect lcall without *'
{standard input}:1318: Warning: indirect lcall without *'
{standard input}:1393: Warning: indirect lcall without *'
{standard input}:1404: Warning: indirect lcall without *'
{standard input}:1415: Warning: indirect lcall without *'
{standard input}:1889: Warning: indirect lcall without *'
{standard input}:1985: Warning: indirect lcall without *'

gcc -D__KERNEL__ -I/opt/home/benoit/src/linux-2.4.11-pre4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686 -c -o pci-irq.o pci-irq.c

gcc -D__KERNEL__ -I/opt/home/benoit/src/linux-2.4.11-pre4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686 -DEXPORT_SYMTAB -c mtrr.c

gcc -D__KERNEL__ -I/opt/home/benoit/src/linux-2.4.11-pre4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686 -c -o mpparse.o mpparse.c

mpparse.c: In function `MP_processor_info':
mpparse.c:195: `Clustered_apic_mode' undeclared (first use in this function)
mpparse.c:195: (Each undeclared identifier is reported only once
mpparse.c:195: for each function it appears in.)
mpparse.c: In function `Smp_read_mpc':
mpparse.c:386: `Clustered_apic_mode' undeclared (first use in this function)
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory
/opt/home/benoit/src/linux-2.4.11-pre4/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

=2Econfig:

# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy

/B.

--=20
Sebastian Benoit <ben-lists@andastra.de> / Software Engineer
Andastra GmbH Germany / phone ++49 6081 682-200 / fax -299
OpenPGP-Key ID 0x82AE75E4                            =20
fingerprint 0BDA 0CB7 9BCA AF77 28EE  D91A 396D 93BC 82AE 75E

Quidquid latine dictum sit, altum viditur.

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7vZLCOW2TvIKudeQRAgWaAJ0Uv2If46XYHgKVjqLEgRmajD7eHgCfWjB2
GyamBfr5DtlXKHMjsD3YfAc=
=Xbjd
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
