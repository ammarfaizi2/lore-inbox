Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261569AbSJURhN>; Mon, 21 Oct 2002 13:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSJURhD>; Mon, 21 Oct 2002 13:37:03 -0400
Received: from guttormur.frisk-software.com ([213.220.100.9]:64199 "EHLO
	guttormur.frisk-software.com") by vger.kernel.org with ESMTP
	id <S261478AbSJURfy>; Mon, 21 Oct 2002 13:35:54 -0400
Subject: System call wrapping
From: =?ISO-8859-1?Q?Henr=FD_=DE=F3r?= Baldursson <henry@f-prot.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-s9K8jnV2bFdf7tzxghTm"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 17:42:01 +0000
Message-Id: <1035222121.1063.20.camel@pc177>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s9K8jnV2bFdf7tzxghTm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Dear sirs,=20
I work for FRISK Software International. We are an Antivirus company.
Our product is the F-Prot Antivirus scanner.=20

We have started to port our application to the Linux platform in an
effort to provide system administrators with means to scan the content
they supply their workstations with via Linux servers.=20
In our Windows product we have something called "Realtime protector"
which monitors file access on Windows running machines and scans them
before allowing access.=20

We now want, due to customer demand, to supply our Linux users with
similar functionality, and we've created a 2.4.x kernel module which
wrapped the open system call by means of overwriting
sys_call_table[__NR_open]. We did realize that this is a bad idea if a
user loads another module doing the same, and then unloads in the wrong
order. And also that this is not a very pretty method. But it worked.=20

Apparently, this is something you kernel hackers don't approve of, since
you've recently removed EXPORT_SYMBOL(sys_call_table) from
kernel/ksyms.c - so my question is whether there is some other preferred
method for accomplishing this without forcing the user to patch and=20
compile a new kernel.  Is there some API for wrapping system calls which
I am unaware of, or are there plans to provide one?=20

Best regards,=20

Henr=FD =DE=F3r Baldursson, Linux Developer=20
FRISK Software International=20
http://www.f-prot.com
http://aves.f-prot.com



--=-s9K8jnV2bFdf7tzxghTm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9tDxpmKhgit64+foRArjHAJwLPoamq8OVUuy3cN3kC3UCkMgWBwCgnrJ8
L1iBhQiyW+ec0PDkk7wdv5M=
=ROEL
-----END PGP SIGNATURE-----

--=-s9K8jnV2bFdf7tzxghTm--

