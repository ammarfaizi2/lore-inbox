Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161252AbWASP4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWASP4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWASP4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:56:12 -0500
Received: from mail.gmx.net ([213.165.64.21]:55429 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161252AbWASP4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:56:12 -0500
X-Authenticated: #5082238
Date: Thu, 19 Jan 2006 17:56:12 +0100
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at include/linux/gfp.h:80
Message-ID: <20060119165612.GA11527@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060119161033.GB12518@carsten-otto.halifax.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20060119161033.GB12518@carsten-otto.halifax.rwth-aachen.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2006 at 05:10:33PM +0100, Carsten Otto wrote:
> My kernel panics at every boot, see screenshot[1].

As indicated the sounddriver seems to have some sort of problem. I
disabled it and now I can boot (without problems).

modprobe snd_emu10k1 gives:

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at include/linux/gfp.h:80
invalid operand: 0000 [1] SMP=20
CPU 1=20
Modules linked in: snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_=
util_mem snd_hwdep nvidia
Pid: 11886, comm: modprobe Tainted: P      2.6.15.1 #5
RIP: 0010:[<ffffffff8015185e>] <ffffffff8015185e>{__get_free_pages+16}
RSP: 0018:ffff8100b5619d08  EFLAGS: 00010202
RAX: 0000000000000005 RBX: 0000000000000003 RCX: 00000000000052d4
RDX: ffff8100b802e090 RSI: 0000000000000003 RDI: 00000000000052d5
RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000300000001
R10: 0000000300000001 R11: 0000000000000001 R12: ffff81012ff14870
R13: ffff8100b802e090 R14: 0000000000008000 R15: ffff8100b802e090
FS:  0000000000859d80(0000) GS:ffffffff806ae880(0000) knlGS:000000000804aba0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaac4cad0 CR3: 00000000b5596000 CR4: 00000000000006e0
Process modprobe (pid: 11886, threadinfo ffff8100b5618000, task ffff8100b6c=
c0a40)
Stack: 00000000000052d4 ffffffff802ad905 0000000000000000 000000007fffffff=
=20
       ffff81012ff14870 ffffffff80000000 ffff8100b802e078 ffffffff803e160b=
=20
       ffffffff884d924e 000000038014cb00=20
Call Trace:<ffffffff802ad905>{swiotlb_alloc_coherent+47} <ffffffff803e160b>=
{snd_dma_alloc_pages+327}
       <ffffffff884cac0d>{:snd_emu10k1:snd_emu10k1_create+1028}
       <ffffffff803cff4d>{snd_info_register+63} <ffffffff884ca0e2>{:snd_emu=
10k1:snd_card_emu10k1_probe+226}
       <ffffffff80429870>{udp_poll+0} <ffffffff802b1e41>{pci_device_probe+8=
6}
       <ffffffff803291cc>{driver_probe_device+65} <ffffffff80329288>{__driv=
er_attach+0}
       <ffffffff803292be>{__driver_attach+54} <ffffffff80328906>{bus_for_ea=
ch_dev+67}
       <ffffffff80328d46>{bus_add_driver+116} <ffffffff802b1cb8>{__pci_regi=
ster_driver+143}
       <ffffffff80149027>{sys_init_module+246} <ffffffff8010d84a>{system_ca=
ll+126}
      =20

Code: 0f 0b 68 c7 ab 4b 80 c2 50 00 48 63 d0 48 6b d2 28 48 81 c2=20
RIP <ffffffff8015185e>{__get_free_pages+16} RSP <ffff8100b5619d08>
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDz8SsjUF4jpCSQBQRAnLNAKDimPT6bSfPWhGRS8xisk4FF1mangCgoFkM
drX/kaAaaxMN5SjFZr3SFOA=
=2wLq
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
