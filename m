Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTJUAql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTJUAql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:46:41 -0400
Received: from h80ad257c.async.vt.edu ([128.173.37.124]:1920 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262854AbTJUAqi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:46:38 -0400
Message-Id: <200310210046.h9L0kHFg001918@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test8-mm1 
In-Reply-To: Your message of "Mon, 20 Oct 2003 17:27:32 PDT."
             <20031020172732.6b6b3646.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20031020020558.16d2a776.akpm@osdl.org> <200310201811.18310.schlicht@uni-mannheim.de> <20031020144836.331c4062.akpm@osdl.org> <200310210001.08761.schlicht@uni-mannheim.de> <200310210014.h9L0EZFP003073@turing-police.cc.vt.edu>
            <20031020172732.6b6b3646.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1887342736P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Oct 2003 20:46:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1887342736P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <1901.1066697159.1@turing-police.cc.vt.edu>

On Mon, 20 Oct 2003 17:27:32 PDT, Andrew Morton said:
> Valdis.Kletnieks@vt.edu wrote:
> >
> > This ring any bells?  What you want tested? etc etc....
> 
> Can you try disabling all fbdev stuff in config?

OK.. That booted just fine, didn't hang in pty_init, didn't hit the
WARN_ON added to fs_inoce.c.

So we have:

works:
#  CONFIG_FB is not set

Doesn't work:
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

I've not had a chance to play binary search on those options yet..  Graphics
card is an NVidia GeForce 440Go, and was previous working just fine with
framebuffer over on vc1-6 and NVidia's driver on an XFree86 on vc7. (OK, I
admit I didn't stress test the framebuffer side much past "penguins and
scroiled text"...)


--==_Exmh_1887342736P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/lIHYcC3lWbTT17ARApF3AKDgMlT3xPJBvSwCVvIfzCeKvTOQaACgreus
1D0iOzxbeyt9kyEK/ZKdzME=
=Chp5
-----END PGP SIGNATURE-----

--==_Exmh_1887342736P--
