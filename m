Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTEYSAC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 14:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTEYSAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 14:00:02 -0400
Received: from h80ad2667.async.vt.edu ([128.173.38.103]:56974 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261710AbTEYSAA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 14:00:00 -0400
Message-Id: <200305251813.h4PID2oH021773@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE 
In-Reply-To: Your message of "Sun, 25 May 2003 10:51:02 CDT."
             <20030525155102.GN23715@waste.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030525000701.GG504@phunnypharm.org> <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
            <20030525155102.GN23715@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1416243708P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 25 May 2003 14:13:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1416243708P
Content-Type: text/plain; charset=us-ascii

On Sun, 25 May 2003 10:51:02 CDT, Matt Mackall said:

> The return value here isn't particularly useful. The OpenBSD
> strlcpy/strlcat variant tell you how big the result should have been
> so that you can realloc if need be.

A quick grep of the current source tree seems to indicate that there aren't
any uses of 'strncpy' that actually save or check the return value.

As such, actually *using*  the return value would make for a job for the
kernel janitors, to actually do something useful at all 650 or so uses.

Given that the kernel probably *shouldn't* be trying to strlcpy() into
a destination that it won't fit, it may be more useful to do a BUG_ON()
or similar (feel free to use a 'goto too_long;' if you prefer ;)


--==_Exmh_-1416243708P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+0QetcC3lWbTT17ARAs/fAKDs+fSKAMAZaoNuciSMmg+N276WjgCdHLgA
43iny6oXZ8hVpg+BBbJ9oUQ=
=+4au
-----END PGP SIGNATURE-----

--==_Exmh_-1416243708P--
