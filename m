Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268333AbTAMUex>; Mon, 13 Jan 2003 15:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268334AbTAMUex>; Mon, 13 Jan 2003 15:34:53 -0500
Received: from h80ad2749.async.vt.edu ([128.173.39.73]:55168 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268332AbTAMUeu>; Mon, 13 Jan 2003 15:34:50 -0500
Message-Id: <200301132043.h0DKhSRX007387@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PRE 
In-Reply-To: Your message of "Mon, 13 Jan 2003 15:28:45 EST."
             <Pine.LNX.3.95.1030113152122.30378A-100000@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.3.95.1030113152122.30378A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_940296840P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jan 2003 15:43:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_940296840P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jan 2003 15:28:45 EST, "Richard B. Johnson" said:

> void foo(int len)
> {
>    char use[0x100];
>    char bar[len];
> }
> 
> In the case of 'use', the compiler subtracts (0x100 * sizeof(char))
> from the current stack value and uses that as the location for 'use'.
> In the case of 'bar' the compiler subtracts (len * sizeof(char))
> from the current stack value and uses that as the location for 'bar'.

One or the other of these is missing a -0x100 for the location...

void foo (int len1, unsigned int len2)
{
  char bar[0x100];
  char baz[len1];
  char quux[len2];
  char moby[8];
}

And moby[6] is *where*? ;)  Bonus points for getting this right if
compiled with -fvomit-stack-pointer. <evil grin> ;)
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_940296840P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+IyTwcC3lWbTT17ARAgVkAJ4j+0gy8PNzlYM8wf4W5a9QBauXawCeLGmD
ogwFuvto53ER2FIn2USpYBg=
=uYKB
-----END PGP SIGNATURE-----

--==_Exmh_940296840P--
