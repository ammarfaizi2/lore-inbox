Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSL2WcL>; Sun, 29 Dec 2002 17:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSL2WcL>; Sun, 29 Dec 2002 17:32:11 -0500
Received: from is-root.org ([217.160.132.177]:13731 "EHLO gentex.is-root.org")
	by vger.kernel.org with ESMTP id <S261978AbSL2WcE>;
	Sun, 29 Dec 2002 17:32:04 -0500
From: "Christian \"cycloon\" Gut" <cycloon@is-root.org>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org, axboe@suse.de
Organization: 
Message-Id: <1041201603.17115.47.camel@vertex.bastion.free-bsd.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0- 
Date: 29 Dec 2002 23:40:03 +0100
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, andre@linux-ide.org, axboe@suse.de
Subject: PROBLEM: Plextor CD-RW hangs when reading via cdrdao/xine/mplayer
	and ide-scsi
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VZ7jfV3NxwnD8LQxgnbB"
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VZ7jfV3NxwnD8LQxgnbB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!
I got some problems with my IDE Burner Plextor 2410TA. Bugreport
following:

[1.]My IDE CD-RW drive hangs when reading a cd via cdrdao/xine/mplayer
and ide-scsi.

[2.]My whole system is compiled with gcc 3.2 (using gentoo). When i try
to read CDs(especially happens with VCDs) with cdrdao, xine, mplayer or
even vcdimager the application suddenly hangs and the CD-Drive doesn't
stop to run and run.
The Problem is not Hardwaredependant, cause it works fine under Knoppix
and Windows. I think it depends on gcc > 3 as it worked before and still
works under Knoppix.

While reading the CD suddenly the application hangs, kern.log shows
scsi-errors and the Drive runs and runs. It can only be reseted with a
reboot(Including Poweroff).
Additionaly I cant use my secondary Drive after the lockup since its
blocked too.
cdrecord -scanbus shows anoying drive informations (look at the end of
the mail).

[3.]Keywords: ide, ide-scsi, scsi, CD-R

[4.]Linux version 2.4.20-ac2 (root@vertex.bastion.free-bsd.org) (gcc
version 3.2) #5 Sun Dec 22 17:13:24 CET 2002

...

[7.1]
# sh scripts/ver_linux
Linux vertex.bastion.free-bsd.org 2.4.20-ac2 #5 Sun Dec 22 17:13:24 CET
2002 i686 AMD Athlon(tm) Processor AuthenticAMD GNU/Linux
=20
Gnu C                  3.2
Gnu make               3.80
util-linux             2.11u
mount                  2.11u
modutils               2.4.20
e2fsprogs              1.29
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.10
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         nls_iso8859-1 sg sr_mod ide-cd cdrom parport_pc
lp parport i2c-dev i2c-proc i2c-core ide-scsi scsi_mod emu10k1
ac97_codec nvidia 8139too mii

[7.2.]
# cat /proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 999.859
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1992.29

[7.3.] Module information (from /proc/modules):

nls_iso8859-1           2876   0 (autoclean)
sg                     28076   0 (autoclean)
sr_mod                 14232   0 (autoclean)
ide-cd                 32188   0 (autoclean)
cdrom                  29184   0 (autoclean) [sr_mod ide-cd]
parport_pc             13508   1 (autoclean)
lp                      6304   0 (autoclean)
parport                14368   1 (autoclean) [parport_pc lp]
i2c-dev                 4740   0 (unused)
i2c-proc                7248   0
i2c-core               13540   0 [i2c-dev i2c-proc]
ide-scsi               10448   0
scsi_mod               56660   3 [sg sr_mod ide-scsi]
emu10k1                72136   0
ac97_codec             10440   0 [emu10k1]
nvidia               1465088  10
8139too                15176   1
mii                     2496   0 [8139too]


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)


0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d800-d81f : VIA Technologies, Inc. USB
  d800-d81f : usb-uhci
dc00-dc1f : VIA Technologies, Inc. USB (#2)
  dc00-dc1f : usb-uhci
e000-e01f : VIA Technologies, Inc. USB (#3)
  e000-e01f : usb-uhci
e400-e41f : Creative Labs SB Audigy
  e400-e41f : Audigy
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e800-e8ff : 8139too
ec00-ec07 : Creative Labs SB Audigy MIDI/Game port
fc00-fc0f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  fc00-fc07 : ide0
  fc08-fc0f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002696c6 : Kernel code
  002696c7-002ec683 : Kernel data
0fff0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
cdc00000-cdcfffff : PCI Bus #01
d0000000-d7ffffff : nVidia Corporation NV11 [GeForce2 MX DDR]
dde00000-ddefffff : PCI Bus #01
defe8000-defebfff : Creative Labs SB Audigy FireWire Port
defed000-defedfff : NEC Corporation USB
defee000-defeefff : NEC Corporation USB (#2)
defef000-defef7ff : Creative Labs SB Audigy FireWire Port
defefe00-defefeff : NEC Corporation USB 2.0
defeff00-defeffff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  defeff00-defeffff : 8139too
df000000-dfffffff : nVidia Corporation NV11 [GeForce2 MX DDR]
e0000000-e3ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W2410A Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: HITACHI  Model: DVD-ROM GD-7500  Rev: 0008
  Type:   CD-ROM                           ANSI SCSI revision: 02



[7.7.] Other information that might be relevant=20


KERN.LOG during hangup of cdr-drive:

Dec 29 23:33:02 vertex scsi : aborting command due to timeout : pid
69302, scsi0, channel 0, id 0, lun 0 0xbe 00 00 00 49 3e 00 00 0f 58 00
00=20
Dec 29 23:33:02 vertex hdc: irq timeout: status=3D0xd0 { Busy }
Dec 29 23:33:02 vertex hdc: DMA disabled
Dec 29 23:33:32 vertex scsi : aborting command due to timeout : pid
69302, scsi0, channel 0, id 0, lun 0 0xbe 00 00 00 49 3e 00 00 0f 58 00
00=20
Dec 29 23:33:32 vertex SCSI host 0 abort (pid 69302) timed out -
resetting
Dec 29 23:33:32 vertex SCSI bus is being reset for host 0 channel 0.
Dec 29 23:33:33 vertex scsi : aborting command due to timeout : pid
69302, scsi0, channel 0, id 0, lun 0 0xbe 00 00 00 49 3e 00 00 0f 58 00
00=20
Dec 29 23:33:33 vertex SCSI host 0 abort (pid 69302) timed out -
resetting
Dec 29 23:33:33 vertex SCSI bus is being reset for host 0 channel 0.
Dec 29 23:33:33 vertex scsi : aborting command due to timeout : pid
69302, scsi0, channel 0, id 0, lun 0 0xbe 00 00 00 49 3e 00 00 0f 58 00
00=20
Dec 29 23:33:33 vertex SCSI host 0 abort (pid 69302) timed out -
resetting
Dec 29 23:33:33 vertex SCSI bus is being reset for host 0 channel 0.
Dec 29 23:33:34 vertex scsi : aborting command due to timeout : pid
69302, scsi0, channel 0, id 0, lun 0 0xbe 00 00 00 49 3e 00 00 0f 58 00
00=20
Dec 29 23:33:34 vertex SCSI host 0 abort (pid 69302) timed out -
resetting
Dec 29 23:33:34 vertex SCSI bus is being reset for host 0 channel 0.
...and so on...




cdrecord -scanbus after lockup:

even couldnt get this anymore. any program accessing the ide-drive locks
completely.


--=20
Christian "cycloon" Gut <cycloon@is-root.org>

--=-VZ7jfV3NxwnD8LQxgnbB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+D3nCx7jl1ui8gtARArq4AJ4gFo9TxwwIhBuhBQFkRiIQyX5wCwCfXrkd
RuXtpq2xchnsLPBCtY3bRTo=
=6aI4
-----END PGP SIGNATURE-----

--=-VZ7jfV3NxwnD8LQxgnbB--

