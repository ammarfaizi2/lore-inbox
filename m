Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTAWQrJ>; Thu, 23 Jan 2003 11:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTAWQrI>; Thu, 23 Jan 2003 11:47:08 -0500
Received: from h80ad266c.async.vt.edu ([128.173.38.108]:1665 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265424AbTAWQrH>; Thu, 23 Jan 2003 11:47:07 -0500
Message-Id: <200301231655.h0NGtc75010414@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: User & <breno_silva@beta.bandnet.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Expand VM 
In-Reply-To: Your message of "Thu, 23 Jan 2003 12:56:27 -0300."
             <20030123155627.M95099@beta.bandnet.com.br> 
From: Valdis.Kletnieks@vt.edu
References: <20030123155627.M95099@beta.bandnet.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-611055225P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Jan 2003 11:55:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-611055225P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jan 2003 12:56:27 -0300, User & <breno_silva@beta.bandnet.com.=
br>  said:

> I have one idea , and this is about expand virtual memory on linux boxe=
s =

> connected in LAN.
> Example: Linux A is processing come information , and need more memory =
, so =

> with this source , Linux A could access virtual memory on Linux B in LA=
N.

We've seen *this* done before (remember diskless Sun3-50's?) - the /dev/s=
wap
file would be a large file on an NFS mount from a server.  At the time, t=
his
actually made performance sense, because the old 'Shoebox' drives the -50=

came with were incredibly slow, and you could actually do an NFS operatio=
n
to a larger server (a -280 with Fujitsu SuperEagle disks, for instance) f=
aster
than talking to the local disk.

These days, it's probably easier and cheaper to just buy more RAM and/or =
disk
for Linux A.

> But i don=B4t know how translate the virtual address between Linux A an=
d B , to =

> have success in acess VM, or how to send all the process for Linux B to=
 be =

> processed.

Sending the whole process to Linux B to be processed is called "process
migration", and is a difficult problem.  Moving the memory image of the
process is usually pretty easy.  What is difficult is moving things like
references to open files, file locks, and so on (what if the process is
actively writing to block 739 of /usr/foo/some.file, and the LinuxB machi=
ne
doesn't have a /usr/foo, or the permissions on some.file don't match, or
another process has it locked, or... ) There be nasty dragons in this.

You're probably better off buying more RAM and disk for your A machine.
-- =

				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-611055225P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+MB6JcC3lWbTT17ARAuexAJwLrltP3SXr6WmTWFRYjNuRJwPKlwCgj6EF
VpCtNgJjya2urr5J3HNxX+o=
=b/UE
-----END PGP SIGNATURE-----

--==_Exmh_-611055225P--
