Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTD0IlC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 04:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTD0IlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 04:41:02 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:62451 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263286AbTD0IlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 04:41:01 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: Oop in 2.5.68-mm2 apply_alternatives
Date: Sun, 27 Apr 2003 10:53:00 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200304271013.47047.schlicht@uni-mannheim.de> <20030427012149.285bbde9.akpm@digeo.com>
In-Reply-To: <20030427012149.285bbde9.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_1p5q+8rDw3FHgNO";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304271053.09604.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_1p5q+8rDw3FHgNO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On April 27, Andrew Morton wrote:
> Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
> > I get following (hand copied) Oops at init when booting 2.5.68-mm2.
>
> You'll need to delete the `__init' qualifier from the definition
> of arch/i386/kernel/setup.c:apply_alternatives()

Thank you!
Sorry I missed the thread from Petr Vandrovec and Rusty Russell before.
Now I changed __init to __init_or_module as Rusty proposed and it works=20
fine...

   Thomas Schlichter
--Boundary-02=_1p5q+8rDw3FHgNO
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+q5p1YAiN+WRIZzQRAq/jAJ4h3z5k+Dflgc9CrnvpjM98HZ3UMACfUSUz
ahXXLrOlWt+SBQmVnG22oYM=
=Z22w
-----END PGP SIGNATURE-----

--Boundary-02=_1p5q+8rDw3FHgNO--

