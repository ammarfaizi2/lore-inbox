Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVEGVpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVEGVpq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 17:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVEGVpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 17:45:46 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:5582 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262753AbVEGVpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 17:45:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Subject: Re: [PATCH] implement nice support across physical cpus on SMP
Date: Sun, 8 May 2005 07:45:32 +1000
User-Agent: KMail/1.8
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
References: <200505072342.32997.kernel@kolivas.org> <17021.486.683745.867241@fisica.ufpr.br>
In-Reply-To: <17021.486.683745.867241@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1834525.zM7EFSxZ52";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505080745.36906.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1834525.zM7EFSxZ52
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 8 May 2005 03:59, Carlos Carvalho wrote:
> Con Kolivas (kernel@kolivas.org) wrote on 7 May 2005 23:42:
>  >SMP balancing is currently designed purely with throughput in mind. This
>  >working patch implements a mechanism for supporting 'nice' across
>  > physical cpus without impacting throughput.
>  >
>  >This is a version for stable kernel 2.6.11.*
>  >
>  >Carlos, if you could test this with your test case it would be
>  > appreciated.
>
> Unfortunately it doesn't seem to have any effect:
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>   184 user1    39  19  7220 5924  520 R 99.9  1.1 209:40.68 mi41
>   266 user2    25   0  1760  480  420 R 50.5  0.1  86:36.31 xdipole1
>   227 user3    25   0  155m  62m  640 R 49.5 12.3  95:07.89 b170-se.x
>
> Note that the nice 19 job monopolizes one processor while the other
> two nice 0 ones share a single processor.
>
> This is really a showstopper for this kind of application :-(

Ok back to the drawing board. I have to try and figure out why it doesn't w=
ork=20
for your case. I tried it on 4x with lots of cpu bound tasks so I'm not sur=
e=20
why it doesn't help with tyours.

Cheers,
Con

--nextPart1834525.zM7EFSxZ52
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCfTcAZUg7+tp6mRURAsDNAJ9J5vAdRJpHtMdZXq+vS8K0+/NiYQCfRzDC
xsLgJGQ4mGavyODfLQrdJro=
=K0M0
-----END PGP SIGNATURE-----

--nextPart1834525.zM7EFSxZ52--
