Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266062AbUALGLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 01:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266060AbUALGLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 01:11:31 -0500
Received: from h80ad24b1.async.vt.edu ([128.173.36.177]:37248 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266068AbUALGL3 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 01:11:29 -0500
Message-Id: <200401120611.i0C6BH7c003591@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error 
In-Reply-To: Your message of "Sun, 11 Jan 2004 21:42:59 PST."
             <20040111214259.568cff35.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040109014003.3d925e54.akpm@osdl.org> <3FFF79E5.5010401@winischhofer.net> <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org> <200401112353.43282.gene.heskett@verizon.net>
            <20040111214259.568cff35.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-752633002P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jan 2004 01:11:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-752633002P
Content-Type: text/plain; charset=us-ascii

On Sun, 11 Jan 2004 21:42:59 PST, Andrew Morton said:
> Gene Heskett <gene.heskett@verizon.net> wrote:
> >  hubble of about 4 or 5 months back.  In any other kernel, switching 
> >  to that window took about 12 seconds for the backdrop to be converted 
> >  to 1600x1200x32 and drawn the first time and about 8 seconds for the 
> >  next time.  But with this 2.6.1-mm1 kernel, that repeat window switch 
> >  is so close to instant that I cannot see it being drawn.

> There are no significant fbdev patches in 2.6.1-mm1.  There is a DRM
> update.

The 12 seconds coming and 8 seconds going, versus instant, sounds an *awful*
lot like the virtual memory manager making better choices in -mm kernels, so
the pages of pixmap are staying in memory rather than paging out.

Other guess is that o21-sched.patch is DTRT, while the stock scheduler DTWT
for his particular config.

Gene:  Can you tell what exactly your system is doing for the 12/8 seconds?  Is it
CPU bound, or beating on the disk while paging in/out, or just sitting idle?  Leaving
a 'vmstat 1' running while you change backdrops should tell us something.

--==_Exmh_-752633002P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAAjqFcC3lWbTT17ARAoQQAJ9xCT+kjdTlD71HjV39ZtnHUIS/zQCgydL9
2bBhB3aAJTbvOkRZDeU+/uo=
=czGy
-----END PGP SIGNATURE-----

--==_Exmh_-752633002P--
