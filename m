Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTKGF2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 00:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTKGF2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 00:28:23 -0500
Received: from h80ad25c7.async.vt.edu ([128.173.37.199]:21632 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261464AbTKGF2U (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 00:28:20 -0500
Message-Id: <200311070528.hA75SFe8006038@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: load 2.4.x binary only module on 2.6 
In-Reply-To: Your message of "Thu, 06 Nov 2003 19:42:39 EST."
             <200311061942.39053.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <20031106153004.GA30008@ds9.ch> <200311061505.28953.gene.heskett@verizon.net> <200311062023.hA6KNnHG005148@turing-police.cc.vt.edu>
            <200311061942.39053.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1749875884P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Nov 2003 00:28:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1749875884P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <6029.1068182894.1@turing-police.cc.vt.edu>

On Thu, 06 Nov 2003 19:42:39 EST, Gene Heskett said:

> Dunno.  Card here is a gforce2-mx200, 32megs, your basic throwaway 
> card.  X is 4.1.0, and I'm looking to see if I have the vesafb turned 
> on, but I cannot find that as an option, and a grep of .config comes 
> back empty.

Hmm... I'm using XFree86 4.3.0, which probably makes a big difference.

Also, try tweaking the values of NvAGP in the XF86Config-4 file
(I'm using NvAGP=3, your mileage may vary, depending on whether the 
NVidia AGP support or the agpgart version plays nicer with your box).

Here's the relevant .config I'm using (oh, and I use 'vga=794' at
boot, which gives me a 64x160 char display..

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

Works for me, hopefully something here will click and we'll figure out
why it isn't working for you...

--==_Exmh_-1749875884P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/qy1ucC3lWbTT17ARAqU+AJ4quGAAON6WZJy4o1qXsCOxuBdyvwCgjcWV
E5uWNAMoLMHz0nVjTTeC3mo=
=m4Fu
-----END PGP SIGNATURE-----

--==_Exmh_-1749875884P--
