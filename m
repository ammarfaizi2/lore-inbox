Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265530AbUGGWAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUGGWAw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUGGWAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:00:52 -0400
Received: from smtp08.auna.com ([62.81.186.18]:7100 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S265530AbUGGWAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:00:48 -0400
Date: Thu, 8 Jul 2004 00:00:47 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ALSA oops in 2.6.7-mm6
Message-ID: <20040707220047.GA4462@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
X-Mailer: Balsa 2.0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all...

I get this as soon as I try to adjust a control on gnome-alsa-mixer:

Jul  7 18:06:58 werewolf kernel: bad: scheduling while atomic!
Jul  7 18:06:58 werewolf kernel:  [schedule+1743/2172] schedule+0x6cf/0x87c
Jul  7 18:06:58 werewolf kernel:  [__alloc_pages+145/720] __alloc_pages+0x9=
1/0x2d0
Jul  7 18:06:58 werewolf kernel:  [pg0+945635588/1069547520] snd_ctl_read+0=
x1fa/0x2c4 [snd]
Jul  7 18:06:58 werewolf kernel:  [schedule_timeout+173/175] schedule_timeo=
ut+0xad/0xaf
Jul  7 18:06:58 werewolf kernel:  [pg0+945635900/1069547520] snd_ctl_poll+0=
x6e/0x88 [snd]
Jul  7 18:06:58 werewolf kernel:  [<f89d223c>] snd_ctl_poll+0x6e/0x88 [snd]
Jul  7 18:06:58 werewolf kernel:  [do_pollfd+74/127] do_pollfd+0x4a/0x7f
Jul  7 18:06:58 werewolf kernel:  [do_poll+152/183] do_poll+0x98/0xb7
Jul  7 18:06:58 werewolf kernel:  [sys_poll+418/558] sys_poll+0x1a2/0x22e
Jul  7 18:06:58 werewolf kernel:  [sys_ioctl+245/673] sys_ioctl+0xf5/0x2a1
Jul  7 18:06:58 werewolf kernel:  [__pollwait+0/193] __pollwait+0x0/0xc1
Jul  7 18:06:58 werewolf kernel:  [sys_read+56/89] sys_read+0x38/0x59
Jul  7 18:06:58 werewolf kernel:  [sysenter_past_esp+82/113] sysenter_past_=
esp+0x52/0x71

one other:

Jul  7 18:20:50 werewolf kernel: bad: scheduling while atomic!
Jul  7 18:20:50 werewolf kernel:  [schedule+1743/2172] schedule+0x6cf/0x87c
Jul  7 18:20:50 werewolf kernel:  [write_chan+461/519] write_chan+0x1cd/0x2=
07
Jul  7 18:20:50 werewolf kernel:  [pg0+945635588/1069547520] snd_ctl_read+0=
x1fa/0x2c4 [snd]
Jul  7 18:20:50 werewolf kernel:  [normal_poll+338/390] normal_poll+0x152/0=
x186
Jul  7 18:20:50 werewolf kernel:  [schedule_timeout+173/175] schedule_timeo=
ut+0xad/0xaf
Jul  7 18:20:50 werewolf kernel:  [pg0+945635900/1069547520] snd_ctl_poll+0=
x6e/0x88 [snd]
Jul  7 18:20:50 werewolf kernel:  [do_pollfd+74/127] do_pollfd+0x4a/0x7f
Jul  7 18:20:50 werewolf kernel:  [do_poll+152/183] do_poll+0x98/0xb7
Jul  7 18:20:50 werewolf kernel:  [sys_poll+418/558] sys_poll+0x1a2/0x22e
Jul  7 18:20:50 werewolf kernel:  [__pollwait+0/193] __pollwait+0x0/0xc1
Jul  7 18:20:50 werewolf kernel:  [sys_read+56/89] sys_read+0x38/0x59
Jul  7 18:20:50 werewolf kernel:  [sysenter_past_esp+82/113] sysenter_past_=
esp+0x52/0x71

Kernel is 2.6.7-mm6 just with aic7xxx update from Justin's site.
Something is broken between ALSA and preempt, perhaps ?

Any idea ?

BTW, will the aic update ever get to mainline ? Or at least -mm ;)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Cooker) for i586
Linux 2.6.7-jam10 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-1mdk)) #1

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7HKPRlIHNEGnKMMRAurbAKCRZRM2c5vqnjwuXt4Cq0wjlo8mugCfe9SI
Ko2TsoiYfZFFB5UF0KrCxfc=
=xOLl
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
