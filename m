Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTBKJRn>; Tue, 11 Feb 2003 04:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbTBKJRn>; Tue, 11 Feb 2003 04:17:43 -0500
Received: from h80ad257a.async.vt.edu ([128.173.37.122]:44424 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267329AbTBKJRm>; Tue, 11 Feb 2003 04:17:42 -0500
Message-Id: <200302110927.h1B9R0jB006474@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Frank Davis <fdavis@si.rr.com>,
       Vineet M Abraham <vmabraham@hotmail.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] 2.5.59 : drivers/net/fc/iph5526.c 
In-Reply-To: Your message of "Tue, 11 Feb 2003 10:01:37 +0100."
             <200302110901.h1B91cfa013400@eeyore.valparaiso.cl> 
From: Valdis.Kletnieks@vt.edu
References: <200302110901.h1B91cfa013400@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_593412642P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Feb 2003 04:26:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_593412642P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 Feb 2003 10:01:37 +0100, Horst von Brand said:

> > > > > -	for (i = 0; i < clone_list[i].vendor_id != 0; i++)

> It isn't, as written. Something is very wrong in any case, as it should
> have blown up somewhere before.

Well, currently, there's only like 3 entries in the table - two clones
and a null. So for i=0 and i=1, 'i<vendor_id' happens to be true, and we
compare that to a zero. Then for i=2, i is greater than the terminating
null in the table, and we compare THAT to zero.

> In any case, the != 0 is redundant, idiomatic C is to just go:
> 
>      for (i=0; clone_list[i].vendor_id; i++) {...

True.  Notice I said "what was intended", not "what is idiomatic". ;)
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_593412642P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+SMHjcC3lWbTT17ARAjdaAKCBi35XmTxLZt4V0tVkI5x9U7slpQCfQZzG
EMLcY+u6zabp68cS7iWF2yo=
=zZWr
-----END PGP SIGNATURE-----

--==_Exmh_593412642P--
