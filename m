Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265677AbUATSyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUATSyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:54:05 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1153 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265667AbUATSxh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:53:37 -0500
Message-Id: <200401201853.i0KIrS6Z025026@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: GCS <gcs@lsc.hu>, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5 dies booting, possibly network related 
In-Reply-To: Your message of "Tue, 20 Jan 2004 10:23:02 PST."
             <20040120102302.47fa26cd.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040120000535.7fb8e683.akpm@osdl.org> <400D083F.6080907@aitel.hist.no> <20040120175408.GA12805@lsc.hu>
            <20040120102302.47fa26cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-788672706P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jan 2004 13:53:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-788672706P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Jan 2004 10:23:02 PST, Andrew Morton said:

> So yes, whatever compiler you are using, turn off CONFIG_REGPARM - it is
> still very experimental.
> 
> (And of dubious value - it only saved me 0.6% of program text).

I wonder if this is because the x86 architecture is relatively
register-starved, and as a result, we pass the parameters in registers, but the
first thing the function has to do is store half of them on the stack so it has
enough free registers to work with.  If this is the case then regparm(1) or
regparm(2) may do better/worse by changing how much register pressure the
function starts off with.


--==_Exmh_-788672706P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFADXkncC3lWbTT17ARAgeJAKDwWfjDrBU+PoG9pOM1ELoPRZOjFQCfQVNE
btfwJMSQmfoNwaakY1tnsMc=
=BU2N
-----END PGP SIGNATURE-----

--==_Exmh_-788672706P--
