Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVAKImu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVAKImu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVAKImm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:42:42 -0500
Received: from www.nuit.ca ([66.11.160.83]:16519 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S262589AbVAKImc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:42:32 -0500
Date: Tue, 11 Jan 2005 03:42:29 -0500
From: Simon Raven / Eric =?utf-8?B?Uy4gQ8O0dMOp?= <simon@nuit.ca>
To: linux-kernel@vger.kernel.org
Subject: useful info out of tulip weirdness
Message-ID: <20050111084222.GA15167@smtp.nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
X-GPG-KeyServer: hkp://subkeys.pgp.net
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.6+20040907i
X-Scan-Signature: smtp.nuit.ca 1CoHbi-000434-AW dcb92772a5c9958a2a221b07ba65dd9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


earlier today i tried modprobing tulip driver:

modprobe tulip
Oops: kernel access of bad area, sig: 11 [#1]
NIP: E1D843FC LR: E1D84358 SP: DEBC9D80 REGS: debc9cd0 TRAP: 0300    Not ta=
inted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 81000030, DSISR: 40000000
TASK =3D df766770[4988] 'modprobe' THREAD: debc8000
Last syscall: 128
GPR00: E1D85D90 DEBC9D80 DF766770 DD7AD000 00000000 00000000 DD7AD9FC E1D8D=
448
GPR08: DFB9B860 81000030 4B87AD6E E1D8D498 93003533 1001E284 100013A4 DEBC9=
D88
GPR16: 00000000 E1D896FC 00000019 C0A74848 DFB9B230 E1D90000 E1D90000 00000=
004
GPR24: DFB9B220 93003535 81000000 C0A74800 DFB9B000 00000050 81000000 00000=
000
NIP [e1d843fc] tulip_init_one+0x2e8/0xd28 [tulip]
LR [e1d84358] tulip_init_one+0x244/0xd28 [tulip]
Call trace:
 [c0182b28] pci_device_probe_static+0x6c/0x88
 [c0182b94] __pci_device_probe+0x50/0x70
 [c0182be4] pci_device_probe+0x30/0x60
 [c01bfdf8] driver_probe_device+0x4c/0xa0
 [c01bff90] driver_attach+0x88/0xc8
 [c01c057c] bus_add_driver+0xa0/0x10c
 [c01c0c08] driver_register+0x30/0x40
 [c0182f0c] pci_register_driver+0x70/0xa0
 [e1d6204c] tulip_init+0x4c/0xf0 [tulip]
 [c003686c] sys_init_module+0x220/0x320
 [c0003ec0] ret_from_syscall+0x0/0x44
zsh: 4988 segmentation fault  modprobe tulip

the machine soon after had a hard lock. also hotplug "thought" tulip
was loaded. which it kinda was, totally inoperable. by this i mean i
couldn't bind an eth2 to it even if i wanted to do that.

arch: ppc32
cpu: PPC 750/300 MHz

lspci:

0000:00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (r=
ev 03)
0000:00:0d.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro=
 (rev dc)
0000:00:0e.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 0=
3)
0000:00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev =
20)
0000:00:10.0 ff00: Apple Computer Inc. Grand Central I/O (rev 02)
0000:01:00.0 Memory controller: Adaptec AIC-7815 RAID+Memory Controller IC =
(rev 02)
0000:01:04.0 SCSI storage controller: Adaptec 78902
0001:02:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (r=
ev 03)
0001:02:0d.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane (=
rev 30)
0001:02:0e.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U

/proc/cpuinfo:

processor       : 0
cpu             : 740/750
temperature     : 32 C (uncalibrated)
clock           : 195MHz
revision        : 2.2 (pvr 0008 0202)
bogomips        : 602.11
machine         : Power Macintosh
motherboard     : AAPL,9500 MacRISC
detected as     : 16 (PowerMac 9500/9600)
pmac flags      : 00000000
memory          : 512MB
pmac-generation : OldWorld


please CC: me

--=20
"I believe that part of what propels science is the thirst for wonder.  It'=
s a
very powerful emotion.  All children feel it.  In a first grade classroom
everybody feels it; in a twelfth grade classroom almost nobody feels it, or
at least acknowledges it.  Something happens between first and twelfth grad=
e,
and it's not just puberty.  Not only do the schools and the media not teach
much skepticism, there is also little encouragement of this stirring sense
of wonder.  Science and pseudoscience both arouse that feeling.  Poor
popularizations of science establish an ecological niche for pseudoscience."
            -- Carl Sagan, The Burden Of Skepticism,
			The Skeptical Inquirer, Vol. 12, Fall 87

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQeORbWqIeuJxHfCXAQKwDQv+PeO3qChTtcr9EIs2wPOPKvQoKfm7AqIF
E3/aYHzE6YnmMkodsKyPIiW54KZAA9ODHYLVF5XGocFYAzaZNQn+WV3+rOmvKoCB
OgsuJvYoAB20j79CwFjRujAqukD6yvIY4TwC78MVSQCAQ8A9MfexKPP0ziyKHtJ6
0nhrl5tXBwD0kLSYFnWYs21A9nZGbYEK92dJb47EfPVV3BC2MAAGAIEJ1Pvl8BOU
pdfbXv1BrFxSZbdNKfIiZrTEc17+SHFphfqeWpl/R4DNPprN2DYClYYccnDK72qO
dv9X31B/kmx8DUMPARnhwB6GBgq2TAMvV2JCHHSF6yzsQ8jt+JdfNIDekxBcfzyx
c1Cn2r5sMWpRMewqAwfVnJlzk19PPbxcIelnOAbFo7AQuXGGJl8eyvunV46BwV6K
ujyPR+LrjG36uL7vX3gATmPYL7HeR8O0kQLPvmgsOAyDuHZIZwHxrb6uPmd1YvOo
2X4tHk5HFGav+gQJIj5WEWT4NU7t/UvM
=Oolk
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
