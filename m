Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268554AbTANDT4>; Mon, 13 Jan 2003 22:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268555AbTANDT4>; Mon, 13 Jan 2003 22:19:56 -0500
Received: from h80ad26f3.async.vt.edu ([128.173.38.243]:4482 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268554AbTANDTy>; Mon, 13 Jan 2003 22:19:54 -0500
Message-Id: <200301140328.h0E3SFqZ004587@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup 
In-Reply-To: Your message of "Tue, 14 Jan 2003 12:55:40 +1100."
             <20030114025452.656612C385@lists.samba.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030114025452.656612C385@lists.samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1500533200P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jan 2003 22:28:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1500533200P
Content-Type: text/plain; charset=us-ascii

On Tue, 14 Jan 2003 12:55:40 +1100, Rusty Russell said:
> Everyone loves reimplementing strdup. 

> +char *kstrdup(const char *s, int gfp)
> +{
> +	char *buf = kmalloc(strlen(s)+1, gfp);
> +	if (buf)
> +		strcpy(buf, s);
> +	return buf;
> +}

Out of curiosity, who's job is it to avoid the race condition between when
this function takes the strlen() and the other processor makes it a longer
string before we return from kmalloc() and do the strcpy()?


--==_Exmh_1500533200P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+I4POcC3lWbTT17ARAi0QAJ4ubZHKMEBo8hrJG2nsIKRH16XAYwCfd/2V
iE95SeJnHdmPTYCxXBm436U=
=xTQD
-----END PGP SIGNATURE-----

--==_Exmh_1500533200P--
