Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbUAECYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 21:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUAECYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 21:24:32 -0500
Received: from h80ad2514.async.vt.edu ([128.173.37.20]:56507 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265845AbUAECYb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 21:24:31 -0500
Message-Id: <200401050224.i052OAtO003277@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word 
In-Reply-To: Your message of "Sun, 04 Jan 2004 20:02:36 EST."
             <20040105010236.GA24001@mark.mielke.cc> 
From: Valdis.Kletnieks@vt.edu
References: <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <20040104223710.GY4176@parcelfarce.linux.theplanet.co.uk>
            <20040105010236.GA24001@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2006649564P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jan 2004 21:24:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2006649564P
Content-Type: text/plain; charset=us-ascii

On Sun, 04 Jan 2004 20:02:36 EST, Mark Mielke said:

> If and when this comes up in 2.7 development, I would like to see an
> option of the sort: 1) Try to maintain major:minor numbers across
> reboots (even at the expense of complexity and efficiency), 2) Try to
> maintain a subset of the major:minor numbers across reboots
> (compromise) 3) Provide the most efficient implementation, making no
> guarantees regarding the numbering scheme, unless using a numbering
> scheme turns out to be more efficient. Deprecate 1), and let 2) and 3)
> evolve until we see who the victor is... :-) As long as the interface
> that maps device to number is abstracted, the above should be pluggable.

I'd recommend (at least during 2.7) some code in the allocator:

	if (LINUX_VERSION_CODE % 3) {
		major ^= get_random_bytes(4);
		minor ^= get_random_bytes(4);
	}

Just to keep everybody honest. :)

--==_Exmh_-2006649564P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+MrJcC3lWbTT17ARAtC0AJ97WSkxPcV+er4tiKyJz9s5Vzm0hQCfU+e/
N0lF9dBE9utLLIXMas0XC9k=
=pxAl
-----END PGP SIGNATURE-----

--==_Exmh_-2006649564P--
