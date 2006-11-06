Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423496AbWKFEro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423496AbWKFEro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 23:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423498AbWKFEro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 23:47:44 -0500
Received: from mail.isohunt.com ([69.64.61.20]:55018 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1423496AbWKFErn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 23:47:43 -0500
X-Spam-Check-By: mail.isohunt.com
Date: Sun, 5 Nov 2006 20:47:52 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: [x86_64] soft lockup with sunrpc/nfsd (also DWARF2 unwinder stuck)
Message-ID: <20061106044752.GP15897@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96dIhm/ZjrNld+BP"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96dIhm/ZjrNld+BP
Content-Type: multipart/mixed; boundary="1HuzLmPZrG5RH6bG"
Content-Disposition: inline


--1HuzLmPZrG5RH6bG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The -git head as of today (2.6.19-rc4-git9) has a bug with SunRPC by the lo=
oks
of it.=20

Motherboard: Intel DG965RY
Core: Intel Core2 Duo E6400
Memory: 2x1GB + 2x256MB

> BUG: soft lockup detected on CPU#0!
>=20
> Call Trace:
>  [<ffffffff80266948>] dump_trace+0xaa/0x3ec
>  [<ffffffff80266cc6>] show_trace+0x3c/0x52
>  [<ffffffff80266cf1>] dump_stack+0x15/0x17
>  [<ffffffff802a46a0>] softlockup_tick+0xd5/0xe8
>  [<ffffffff80249b43>] run_local_timers+0x13/0x15
>  [<ffffffff802861f5>] update_process_times+0x4c/0x79
>  [<ffffffff8026e89e>] smp_local_timer_interrupt+0x34/0x54
>  [<ffffffff8026ed85>] smp_apic_timer_interrupt+0x52/0x69
>  [<ffffffff8025acf6>] apic_timer_interrupt+0x66/0x70
> DWARF2 unwinder stuck at apic_timer_interrupt+0x66/0x70
>=20
> Leftover inexact backtrace:
>=20
>  <IRQ>  <EOI>  [<ffffffff8025fd2a>] _spin_lock+0xb/0x14
>  [<ffffffff8020bd51>] do_path_lookup+0x1b9/0x21c
>  [<ffffffff8813713b>] :sunrpc:auth_domain_lookup+0x9e/0x11d
>  [<ffffffff881378b5>] :sunrpc:unix_domain_find+0x17/0xad
>  [<ffffffff88137b05>] :sunrpc:ip_map_parse+0x106/0x175
>  [<ffffffff8023788d>] debug_mutex_free_waiter+0x52/0x56
>  [<ffffffff8813ab2c>] :sunrpc:cache_write+0x9c/0xd4
>  [<ffffffff80214936>] vfs_write+0xcf/0x175
>  [<ffffffff802152ae>] sys_write+0x47/0x70
>  [<ffffffff8025a11e>] system_call+0x7e/0x83

=2Econfig attached

ver_linux:
Linux grubbs-int 2.6.19-rc4 #27 SMP Sat Nov 4 19:03:22 PST 2006 x86_64 Inte=
l(R) Core(TM)2 CPU          6400  @ 2.13GHz GenuineIntel GNU/Linux
=20
Gnu C                  4.1.1
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
jfsutils               1.1.11
xfsprogs               2.8.11
quota-tools            3.13.
Linux C Library        > libc.2.5
Dynamic linker (ldd)   2.5
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.4
udev                   103
Modules Loaded         e1000 e100 bridge llc ahci libata ipv6 nfsd exportfs=
 rtc raid456 xor ohci1394 mii ieee1394 snd_hda_intel snd_hda_codec parport_=
pc snd_pcm parport i2c_i801 snd_timer i2c_core snd psmouse soundcore pcspkr=
 snd_page_alloc evdev 3w_xxxx sr_mod cdrom sg sd_mod dm_snapshot xfs nfs nf=
s_acl lockd sunrpc reiserfs raid10 raid1 raid0 md_mod dm_mirror dm_mod ohci=
_hcd uhci_hcd usb_storage libusual usbhid ehci_hcd usbcore

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--1HuzLmPZrG5RH6bG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="kernel-config-2.6.19-rc4-git9.gz"
Content-Transfer-Encoding: base64

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
pLRsAAA=

--1HuzLmPZrG5RH6bG--

--96dIhm/ZjrNld+BP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFTr54PpIsIjIzwiwRAiWZAJ98hrmTqhAmNvP4odhQ+r1DGIGw3wCdGXLD
ATlgAPXC2Qm/N7e8RXSWoew=
=wKu0
-----END PGP SIGNATURE-----

--96dIhm/ZjrNld+BP--
