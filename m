Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264807AbRFSWES>; Tue, 19 Jun 2001 18:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264810AbRFSWEJ>; Tue, 19 Jun 2001 18:04:09 -0400
Received: from pc2-camb6-0-cust223.cam.cable.ntl.com ([213.107.107.223]:53637
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S264807AbRFSWEB>; Tue, 19 Jun 2001 18:04:01 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tomasz =?iso-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre4 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.com> 
   of "Tue, 19 Jun 2001 17:48:09 EDT." <3B2FC899.3F0105F1@mandrakesoft.com> 
In-Reply-To: <E15CS0l-0006co-00@the-village.bc.nu>  <3B2FC899.3F0105F1@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-570891986P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Jun 2001 23:03:18 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E15CTag-0000Eb-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-570891986P
Content-Type: text/plain; charset=us-ascii

>> It wont build with gcc 3.0 yet. To start with gcc 3.0 will assume it can
>> insert calls to 'memcpy'
>
>IMHO omitting -fno-builtin when compiling the kernel was always a risky
>proposition...  Since we provide our own copies of many of the builtins
>[which are used in the kernel] anyway... why not always -fno-builtin,
>and then call __builtin_foo when we really want the compiler's version..
>
>gcc 3.0 without -fno-builtin is perfectly allowed to assume it can
>insert calls to memcpy..

I don't think -fno-builtin has any bearing on whether gcc will emit calls to 
memcpy; instead it prevents gcc from open-coding them when it thinks it 
understands what's going on.

Try this with gcc -O2 -S, and again with -fno-builtin:

struct s { int a[200]; };

f(struct s *a, struct s *b)
{
  *b = *a;
}

g(int *a, int *b)
{
  memcpy(b, a, 4);
}

p.



--==_Exmh_-570891986P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7L8wmVTLPJe9CT30RAkb5AKCrO6FDwipVFYYwf4FCux+sg4VDawCgqtC2
xsOGUEGne2An1dTav25rcqs=
=XtaQ
-----END PGP SIGNATURE-----

--==_Exmh_-570891986P--
