Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932426AbWFEGCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWFEGCz (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 02:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWFEGCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 02:02:54 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:57029
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932426AbWFEGCy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 02:02:54 -0400
Message-Id: <200606050602.k5562Y4R006843@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
In-Reply-To: Your message of "Mon, 05 Jun 2006 01:15:31 +0200."
             <20060605011531.0bfe67db@werewolf.auna.net>
From: Valdis.Kletnieks@vt.edu
References: <20060603232004.68c4e1e3.akpm@osdl.org>
            <20060605011531.0bfe67db@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149487354_6408P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 02:02:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149487354_6408P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Jun 2006 01:15:31 +0200, "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" said:
> On Sat, 3 Jun 2006 23:20:04 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/

> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {hardirq-on-W} -> {in-hardirq-R} usage.
> idle/0 [HC1[1]:SC1[0]:HE0:SE0] takes:
>  (hl_irqs_lock){--+.}, at: [<f8835cb9>] highlevel_host_reset+0x11/0x5b [ieee1394]
> {hardirq-on-W} state was registered at:
>   [<c0133fe4>] lockdep_acquire+0x4d/0x63
>   [<c02f3421>] _write_lock+0x2e/0x3b
>   [<f88365ab>] hpsb_register_highlevel+0xac/0xea [ieee1394]
>   [<f8836d6a>] init_csr+0x28/0x3f [ieee1394]
>   [<f880617d>] 0xf880617d
>   [<c01398df>] sys_init_module+0x12a/0x1b7b
>   [<c02f3b2d>] sysenter_past_esp+0x56/0x8d

ACK.  I saw this same one too, while udevd was trying to get its act
together in very early rc.sysinit....


--==_Exmh_1149487354_6408P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEg8j6cC3lWbTT17ARAr3GAKDDbhBGbYsn9e03sDH7Kcy7Nxw1BQCg0Hm0
M96Dd9hBCwqFf8/p3M30x8o=
=uL6a
-----END PGP SIGNATURE-----

--==_Exmh_1149487354_6408P--
