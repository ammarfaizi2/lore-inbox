Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUGIUjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUGIUjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUGIUjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:39:22 -0400
Received: from dhcp160179209.columbus.rr.com ([24.160.179.209]:11014 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S263062AbUGIUi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:38:56 -0400
Date: Fri, 9 Jul 2004 16:38:52 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
Message-ID: <20040709203852.GA1997@samarkand.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040708235025.5f8436b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20040708235025.5f8436b7.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 08, 2004 at 11:50:25PM -0700, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7=
-mm7/

> +detect-too-early-schedule-attempts.patch
>=20
>  Catch attempts to call the scheduler before it is ready to go.

    With this patch, my Powermac (ppc32) spews 711 (I think)
warning messages during bootup.  The first one looks like:

Calibrating delay loop... 1064.96 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Badness in schedule at kernel/sched.c:2153
Call trace:
 [c00099e4] dump_stack+0x18/0x28
 [c0006bac] check_bug_trap+0x84/0xac
 [c0006d38] ProgramCheckException+0x164/0x1a4
 [c0006240] ret_from_except_full+0x0/0x4c
 [c02021bc] schedule+0x24/0x684
 [c0005e80] syscall_exit_work+0x108/0x10c
 [c02e0ad0] proc_root_init+0x14c/0x158
 [00000000] 0x0
 [c02ce5a0] start_kernel+0x158/0x184
 [000035fc] 0x35fc

and this goes on until:

Badness in schedule at kernel/sched.c:2153
Call trace:
 [c00099e4] dump_stack+0x18/0x28
 [c0006bac] check_bug_trap+0x84/0xac
 [c0006d38] ProgramCheckException+0x164/0x1a4
 [c0006240] ret_from_except_full+0x0/0x4c
 [c02021bc] schedule+0x24/0x684
 [c00062ec] resume_kernel+0x38/0x58
 [c020249c] schedule+0x304/0x684
 [c002c85c] worker_thread+0x258/0x27c
 [c00317d0] kthread+0xb8/0xc0
 [c0009128] kernel_thread+0x44/0x60
adb devices: [2]: 2 2 [3]: 3 1
ADB keyboard at 2, handler set to 3

    The full dmesg is 322K, and is up at:
http://www.rivenstone.net/linux/samarkand.dmesg

    Most of the traces look something like the bottom one.

--=20
Joseph Fannin
jhf@rivenstone.net

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7wJaWv4KsgKfSVgRArd1AJ9HABUAbUzczJAryxIr1tdkFy/xNwCfR17f
qYT2j0MGKLDYPHGDr62DPL0=
=4Aqi
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
