Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbTABXkn>; Thu, 2 Jan 2003 18:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbTABXkn>; Thu, 2 Jan 2003 18:40:43 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:11404 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S267312AbTABXkm>; Thu, 2 Jan 2003 18:40:42 -0500
Date: Fri, 3 Jan 2003 00:48:58 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       James Simmons <jsimmons@infradead.org>
Subject: [OOPS] Linux v2.5.54 Riva Framebuffer
Message-Id: <20030103004858.3d291fbe.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.8claws22 (GTK+ 1.2.10; Linux 2.5.53)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.:Jkk7G+DbEyH6p"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.:Jkk7G+DbEyH6p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jan 2003 19:43:40 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Happy new year to you all [...]

Happy new year to you, too.

LT> Summary of changes from v2.5.53 to v2.5.54
LT> James Simmons <jsimmons@infradead.org>:
LT>   o Updates to the NVIDIA driver. We now support more cards. I still
LT>     have more hacking to do
LT>   o Voodoo 1 ported to new api. STI and NVIDIA updates. MDA console
LT>     fixes. Moved the logo code from fbcon to fbdev

With Linux 2.5.54 I'm getting an oops in the riva framebuffer driver that didn't
occur with Linux 2.5.53. It seems to be related to aforementioned changes. Trace
copied by hand because I have no serial console.

EIP is at fb_copy_cmap + 0x7f/0x140

Trace:

hide_cursor + 0x75/0x90
get_default_font + 0x209/0x2a0
updatescrollmode + 0x4f3/0x770
rivafb_set_par + 0x88/0xe0
fbcon_bmove_rec + 0x132/0x1f0
set_origin + 0x11d/0x190
clear_buffer_attributes + 0x1aa/0x1d0
put_driver + 0x2f/0x40
do_pre_smp_initcalls + 0x3a/0x160
do_pre_smp_initcalls + 0x0/0x160
show_regs + 0x5/0x18

The card in question is a Geforce 2 GTS.

If more info is required to help solving this problem, let me know.
Please CC: me on any discussion on fbdev-list; I'm only subscribed to lkml.

Regards,
-Udo.

--=.:Jkk7G+DbEyH6p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+FM/tnhRzXSM7nSkRAifRAJ9hJYAdNPcN8UTvAjmsqivNv5e2IwCfZf4A
g+Iho+GlzU56th5T9R2BraY=
=lq7j
-----END PGP SIGNATURE-----

--=.:Jkk7G+DbEyH6p--
