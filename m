Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268226AbTALD4u>; Sat, 11 Jan 2003 22:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268228AbTALD4t>; Sat, 11 Jan 2003 22:56:49 -0500
Received: from h80ad2641.async.vt.edu ([128.173.38.65]:22912 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268226AbTALD4s>; Sat, 11 Jan 2003 22:56:48 -0500
Message-Id: <200301120405.h0C45OLE030336@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI power off requires swsusp (was: Re: Power off a SMP Box) 
In-Reply-To: Your message of "Sat, 11 Jan 2003 13:10:47 +0100."
             <Pine.LNX.4.44.0301111301430.12267-100000@boris.prodako.se> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0301111301430.12267-100000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1017469036P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Jan 2003 23:05:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1017469036P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Jan 2003 13:10:47 +0100, Tobias Ringstrom said:

> I just disovered that in 2.5.56 (at least), ACPI power-off needs
> CONFIG_ACPI_SLEEP which depends on CONFIG_SOFTWARE_SUSPEND.  This means
> that without selecting software suspend, your machine cannot power off
> using ACPI.  Why is it so?

Well.. I submitted  the Kconfig patch that makes it so.  However, I only did
that because there's code inside the ACPI_SLEEP that references a variable over
in SOFTWARE_SUSPEND.

A cleaner fix would probably be to move the variable someplace where it will
exist even when SOFTWARE_SUSPEND isn't defined.
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1017469036P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+IOmEcC3lWbTT17ARAmV9AJ9kT0X1DYunZOzNsDxqVI3Akc7JtgCgwHae
RWNCs8F8T+POTkITtk9vdaI=
=7GD3
-----END PGP SIGNATURE-----

--==_Exmh_1017469036P--
