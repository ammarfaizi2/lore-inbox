Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbTBKEJy>; Mon, 10 Feb 2003 23:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbTBKEJx>; Mon, 10 Feb 2003 23:09:53 -0500
Received: from h80ad257a.async.vt.edu ([128.173.37.122]:45440 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265880AbTBKEJo>; Mon, 10 Feb 2003 23:09:44 -0500
Message-Id: <200302110418.h1B4IbjB002565@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Frank Davis <fdavis@si.rr.com>,
       Vineet M Abraham <vmabraham@hotmail.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, brand@eeyore.valparaiso.cl
Subject: Re: [PATCH] 2.5.59 : drivers/net/fc/iph5526.c 
In-Reply-To: Your message of "Mon, 10 Feb 2003 14:01:13 +0100."
             <200302101301.h1AD1DE2001067@eeyore.valparaiso.cl> 
From: Valdis.Kletnieks@vt.edu
References: <200302101301.h1AD1DE2001067@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-990700808P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Feb 2003 23:18:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-990700808P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Feb 2003 14:01:13 +0100, Horst von Brand said:
> Rusty Russell <rusty@rustcorp.com.au> said:
> 
> [...]
> 
> > > -	for (i = 0; i < clone_list[i].vendor_id != 0; i++)
> 
> i < clone_list[i].vendor_id != 0 is (i < clone_list[i].vendor_id) != 0 is
> just i < clone_list[i].vendor_id, so the for is done for i = 0 and possibly
> for 1. Getting this effect (if desired) with an if is a load clearer.

However, looking at the definition of clone_list[], it's pretty obvious
that this was intended:

    for (i=0; clone_list[i].vendor_id != 0; i++) {...

It's searching through a zero-terminated table of vendor_id's.

It's possible it started off life as
     i < sizeof(clone_list) && clone_list[i].vendor_id != 0

or some such.  
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-990700808P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+SHmccC3lWbTT17ARArCmAJ40SoREERsBG+ZlERr/d+QmX3G1xgCg0AOc
rr3fyyyVfvIJnx9ceHHMBqU=
=MccP
-----END PGP SIGNATURE-----

--==_Exmh_-990700808P--
