Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVITWWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVITWWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVITWWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:22:30 -0400
Received: from smtp05.auna.com ([62.81.186.15]:58615 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S932441AbVITWW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:22:29 -0400
Date: Wed, 21 Sep 2005 00:22:30 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fw: Problems with modular sound
Message-ID: <20050921002230.1f84c227@werewolf.able.es>
X-Mailer: Sylpheed-Claws 1.9.15-rc3 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Wed__21_Sep_2005_00_22_30_+0200_e3FL3G0/_O8j0d0X";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.222.72] Login:jamagallon@able.es Fecha:Wed, 21 Sep 2005 00:22:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__21_Sep_2005_00_22_30_+0200_e3FL3G0/_O8j0d0X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



Begin forwarded message:

Date: Wed, 21 Sep 2005 00:21:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Subject: Problems with modular sound


On Fri, 16 Sep 2005 02:23:19 -0700
Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/=
2.6.14-rc1-mm1/

(sorry if this has appeared already in the list, I have several hundred mai=
ls
pending in my inbox)

I have strange problems with sound:

lsmod:
...
soundcore               7648  0=20
...
werewolf:~# rmmod soundcore
ERROR: Removing 'soundcore': Device or resource busy

Uh ? The count was zero...

werewolf:~# modprobe snd-intel8x0
WARNING: Error inserting snd (/lib/modules/2.6.13-jam5/kernel/sound/core/sn=
d.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-timer (/lib/modules/2.6.13-jam5/kernel/sound/c=
ore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmes=
g)
WARNING: Error inserting snd-pcm (/lib/modules/2.6.13-jam5/kernel/sound/cor=
e/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-ac97-codec (/lib/modules/2.6.13-jam5/kernel/so=
und/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown param=
eter (see dmesg)
FATAL: Error inserting snd-intel8x0 (/lib/modules/2.6.13-jam5/kernel/sound/=
pci/snd-intel8x0.ko): Unknown symbol in module, or unknown parameter (see d=
mesg)

In syslog I have a ton of messages like:

Sep 21 00:18:58 werewolf kernel: snd: Unknown symbol sound_class
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_info_register
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_info_create_=
module_entry
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_info_free_en=
try
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_iprintf
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_ecards_limit
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_unregister_d=
evice
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_device_new
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_info_unregis=
ter
Sep 21 00:18:58 werewolf kernel: snd_timer: Unknown symbol snd_register_dev=
ice
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_info_register
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_info_create_mo=
dule_entry
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_timer_notify
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_timer_interrupt
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_info_free_entry
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_info_get_str
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_ctl_register_i=
octl
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_card_file_add
Sep 21 00:18:58 werewolf kernel: snd_pcm: Unknown symbol snd_iprintf

But the strange thing is that

werewolf:~# depmod -ae
werewolf:~#=20

is silent ?

Somebody understands anything ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.0 (2006 rc2) for i586
Linux 2.6.13-jam5 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))



--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.0 (2006 rc2) for i586
Linux 2.6.13-jam5 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))

--Signature_Wed__21_Sep_2005_00_22_30_+0200_e3FL3G0/_O8j0d0X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDMIumRlIHNEGnKMMRAh++AKCBF6HuGFQs1GtAyU24wGLaV2gdDQCgllCO
OsD77gH6sHLqArYejn+hyAg=
=5jFK
-----END PGP SIGNATURE-----

--Signature_Wed__21_Sep_2005_00_22_30_+0200_e3FL3G0/_O8j0d0X--
