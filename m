Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbTBGRN3>; Fri, 7 Feb 2003 12:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbTBGRN3>; Fri, 7 Feb 2003 12:13:29 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:65410 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265960AbTBGRN2>; Fri, 7 Feb 2003 12:13:28 -0500
Message-Id: <200302071723.h17HN007006168@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.59 : drivers/net/fc/iph5526.c 
In-Reply-To: Your message of "Fri, 07 Feb 2003 12:23:22 EST."
             <Pine.LNX.4.44.0302071221490.6917-100000@master> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0302071221490.6917-100000@master>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-699087380P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Feb 2003 12:23:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-699087380P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <6157.1044638580.1@turing-police.cc.vt.edu>

On Fri, 07 Feb 2003 12:23:22 EST, Frank Davis said:
>
> +++ linux/drivers/net/fc/iph5526.c	2003-02-07 02:13:43.000000000 -0500

> -	for (i = 0; i < clone_list[i].vendor_id != 0; i++)
> +	for (i = 0; ((i < clone_list[i].vendor_id) && (clone_list[i].vendor_id 
!= 0)); i++)

'i < clone_list[i].vendor_id'?

Currently, clone_list only has 1 vendor listed:
#define PCI_VENDOR_ID_INTERPHASE        0x107e

I suspect this was intended:

	for (i = 0; (clone_list[i].vendor_id != 0); i++)
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-699087380P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Q+t0cC3lWbTT17ARAlJsAJ0eMdNPiNmhMSKTlfK6btm1tkrIZgCdHfzH
3lKFf/Sc1mggWyq9YLBIkt0=
=JSqF
-----END PGP SIGNATURE-----

--==_Exmh_-699087380P--
