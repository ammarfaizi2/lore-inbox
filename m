Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUG0QF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUG0QF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUG0QEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:04:01 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:20365 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S266204AbUG0QBH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:01:07 -0400
Subject: 2.6.6 hangs on load change
From: Boris de Laage <emak@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xZAgQRpC2jJG4ln1FAOJ"
Date: Tue, 27 Jul 2004 18:01:29 +0200
Message-Id: <1090944089.2832.17.camel@mandarine.home>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xZAgQRpC2jJG4ln1FAOJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This issue is very similar to "2.6.7-ck5 System hangs under constant
load".

My system sometimes hangs when a task that eats 100% of the CPU is
stopped. The longer the task was running, the more chance the system
have to hang.
I'm using the nvidia's display driver binary module, BUT the problem was
here before.
I've discovered that when I disable the athlon powersaving mode with the
athcool utility, the system doesn't hang. The powersaving mode is
enabled by default:

[root@mandarine root]# athcool stat
athcool version 0.3.5 - enabling/disabling Athlon Powersaving mode
[warning message]
nVIDIA nForce2 (10de 01e0) found
'Halt Disconnect and Stop Grant Disconnect' bit is enabled.


uname -a:
Linux mandarine.home 2.6.6-1.435.2.3 #1 Thu Jul 1 08:25:29 EDT 2004 i686
athlon i386 GNU/Linux

lspci:
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev
c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev
c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev
c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev
c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev
c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
00:05.0 Multimedia audio controller: nVidia Corporation nForce
MultiMedia audio [Via VT82C686B] (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev
a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE
1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:0b.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
03:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4400] (rev a2)

lsmod:
Module                  Size  Used by
nfs                   143936  0
lockd                  47816  1 nfs
sunrpc                109924  3 nfs,lockd
snd_mixer_oss          13824  2
snd_intel8x0           26796  3
snd_ac97_codec         54788  1 snd_intel8x0
snd_pcm                69256  1 snd_intel8x0
snd_timer              17284  1 snd_pcm
snd_page_alloc          8072  2 snd_intel8x0,snd_pcm
gameport                3328  1 snd_intel8x0
snd_mpu401_uart         4864  1 snd_intel8x0
snd_rawmidi            17444  1 snd_mpu401_uart
snd_seq_device          6152  1 snd_rawmidi
snd                    39396  10 snd_mixer_oss,snd_intel8x0,
snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,
snd_seq_device
soundcore               6112  3 snd
nvidia               4817332  12
ipv6                  184672  8
parport_pc             19392  1
lp                      8236  0
parport                29640  2 parport_pc,lp
autofs4                12932  1
w83781d                26368  0
i2c_sensor              2176  1 w83781d
i2c_isa                 1792  0
i2c_core               16660  3 w83781d,i2c_sensor,i2c_isa
forcedeth              10624  0
floppy                 47440  0
sg                     27680  0
dm_mod                 32800  0
joydev                  6976  0
ohci_hcd               16016  0
ehci_hcd               22916  0
button                  4632  0
battery                 6924  0
asus_acpi               8984  0
ac                      3340  0
ext3                  103656  2
jbd                    40728  1 ext3
sata_promise            6276  0
libata                 29188  1 sata_promise
sd_mod                 16384  0
scsi_mod               91984  4 sg,sata_promise,libata,sd_mod

--=20
Boris de Laage <emak@free.fr>
GPG Key: 0xC6082D01

--=-xZAgQRpC2jJG4ln1FAOJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBnxZGrrk3MYILQERAq8XAKCZ5v50WtjyRVrANgYC7q4+tjOoMgCdF0Ad
0J4QHf3vrmXOMvnCNB6O24w=
=gFG7
-----END PGP SIGNATURE-----

--=-xZAgQRpC2jJG4ln1FAOJ--

