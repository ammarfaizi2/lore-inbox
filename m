Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbSJJKAk>; Thu, 10 Oct 2002 06:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263331AbSJJKAj>; Thu, 10 Oct 2002 06:00:39 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:27886 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263330AbSJJKAi>; Thu, 10 Oct 2002 06:00:38 -0400
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
From: Arjan van de Ven <arjanv@fenrus.demon.nl>
To: colpatch@us.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
In-Reply-To: <3DA4D3E4.6080401@us.ibm.com>
References: <3DA4D3E4.6080401@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-19rqhP/Q/f+lZURfxF80"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 12:06:20 +0200
Message-Id: <1034244381.3629.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-19rqhP/Q/f+lZURfxF80
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> +/**
> + * sys_mem_setbinding - set the memory binding of a process
> + * @pid: pid of the process
> + * @memblks: new bitmask of memory blocks
> + * @behavior: new behavior
> + */
> +asmlinkage long sys_mem_setbinding(pid_t pid, unsigned long memblks,=20
> +				    unsigned int behavior)
> +{

Do you really think exposing low level internals as memory layout / zone
split up to userspace is a good idea ? (and worth it given that the VM
already has a cpu locality preference?)

I'd much rather see the VM have an arch-specified "cost" for getting
memory from not-the-prefered zones than exposing all this stuff to
userspace and depending on userspace to do the right thing.... it's the
kernel's task to abstract the low level details of the hardware after
all.

Greetings,
   Arjan van de Ven

--=-19rqhP/Q/f+lZURfxF80
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9pVEcxULwo51rQBIRAmrVAJ9S6Lnim15NFzH+yAlCL5AqB3ryTwCgqcKv
K20p6pLkDRxiXswtnAguUYQ=
=cEkw
-----END PGP SIGNATURE-----

--=-19rqhP/Q/f+lZURfxF80--

