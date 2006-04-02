Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWDBOj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWDBOj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWDBOj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:39:29 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:35793 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932351AbWDBOj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:39:28 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Add prctl to change endian of a task
Date: Sun, 2 Apr 2006 16:37:41 +0200
User-Agent: KMail/1.9.1
References: <20060401222921.GI23416@krispykreme>
In-Reply-To: <20060401222921.GI23416@krispykreme>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1822159.5YcrncgIRZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604021637.49759.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1822159.5YcrncgIRZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Anton,

On Sunday, 2. April 2006 00:29, you wrote:
> Add a prctl to change a tasks endian. While we only have powerpc code to
> implement this so far, it seems like something that warrants a generic
> interface (like setting floating point mode bits).

Most programmers (and thus programs) expect this to be a compile time=20
decision.

What are the reasons of allowing to change it so dynamic at all?

What are the security implications of this?
My naive guess is, that it might defeat range checking of values=20
in user space code.

What about limiting this to be called once per task or VM?
This will prevent most abuse scenarios, I can think of.


Regards

Ingo Oeser

--nextPart1822159.5YcrncgIRZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEL+G9U56oYWuOrkARAuluAKC7oJQZnSxUfSVa7OXcQ5+Gyv5LbwCgkYHC
27uh7vvDamTr98goZg3nCUk=
=YCHE
-----END PGP SIGNATURE-----

--nextPart1822159.5YcrncgIRZ--
