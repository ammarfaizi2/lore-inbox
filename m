Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRAYQ1K>; Thu, 25 Jan 2001 11:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRAYQ1C>; Thu, 25 Jan 2001 11:27:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:23273 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131191AbRAYQZG>;
	Thu, 25 Jan 2001 11:25:06 -0500
Received: from ondrej.office.globe.cz (10.1.2.22)
  by vger.kernel.org with SMTP; 25 Jan 2001 16:23:27 -0000
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre10 slowdown at boot.
From: Ondrej Sury <ondrej@globe.cz>
Date: 25 Jan 2001 17:23:26 +0100
Message-ID: <87k87jzjlt.fsf@ondrej.office.globe.cz>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable


2.4.1-pre10 slows down after printing those (maybe ACPI or reiserfs issue),
and even SysRQ-(s,u,b) is not imediate and waits several (two+) seconds
before (syncing,remounting,booting).

ACPI: System description tables found
ACPI: System description tables loaded
ACPI: Subsystem enabled
ACPI: System firmware supports: C2
ACPI: System firmware supports: S0 S1 S4 S5
reiserfs: checking transaction log (device 03:04) ...
Warning, log replay starting on readonly filesystem


#### OTHER INFO ####

# mount
/dev/hda4 on / type reiserfs (rw,default,default)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=3D5,mode=3D620)
shm on /dev/shm type shm (rw)
/dev/hda2 on /mnt/store type vfat (rw,default,umask=3D000,quiet,uni_xlate,n=
onumtail,codepage=3D852,iocharset=3Diso8859-2)

# cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 0
cpu MHz		: 601.378
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36=
 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1199.30

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev =
02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (r=
ev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Cont=
roller (rev 20)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev =
01)

=2D-=20
Ond=F8ej Sur=FD <ondrej@globe.cz>         Globe Internet s.r.o. http://glob=
e.cz/
Tel: +420235365000   Fax: +420235365009         Pl=E1ni=E8kova 1, 162 00 Pr=
aha 6
Mob: +420605204544   ICQ: 24944126             Mapa: http://globe.namape.cz/
GPG fingerprint:          CC91 8F02 8CDE 911A 933F  AE52 F4E6 6A7C C20D F273
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.5 and Gnu Privacy Guard <http://www.gnupg.org/>

iEYEARECAAYFAjpwUv4ACgkQ9OZqfMIN8nPNVwCfQCMhQGGO4H85+/SGgnNpUdcQ
+n4AoJs0TpVRbxCEs2kR+KS8+ZaUJrO0
=Td22
-----END PGP MESSAGE-----
--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
