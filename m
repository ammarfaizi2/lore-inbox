Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbSLWFsA>; Mon, 23 Dec 2002 00:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbSLWFsA>; Mon, 23 Dec 2002 00:48:00 -0500
Received: from c66-235-4-135.sea2.cablespeed.com ([66.235.4.135]:49246 "EHLO
	darklands.zimres.net") by vger.kernel.org with ESMTP
	id <S266578AbSLWFr7>; Mon, 23 Dec 2002 00:47:59 -0500
Date: Sun, 22 Dec 2002 21:58:00 -0800
From: Thomas Zimmerman <thomas@zimres.net>
To: Andrew Walrond <andrew@walrond.org>
Cc: stephen.willepadnos@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
Message-Id: <20021222215800.67b32268.thomas@zimres.net>
In-Reply-To: <3DFBCFA2.7030603@walrond.org>
References: <200212141355.gBEDtb7q000952@darkstar.example.net>
	<3DFB3983.3090602@walrond.org>
	<3DFB8B7C.10802@verizon.net>
	<3DFBCFA2.7030603@walrond.org>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.wKJ4J)gXD?s3sg"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.wKJ4J)gXD?s3sg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2002 00:41:06 +0000
Andrew Walrond <andrew@walrond.org> wrote:

> Hi steve
> 
> Stephen Wille Padnos wrote:
> > 
> > What would you expect to happen if you then did:
> > echo "d/w" > d/w
> > 
> > Which physical directory would you expect a new file to go into?
> > 
> 
> Using my example:
> 
> mkdir a
> echo "a/x" > a/x
> echo "a/y" > a/y
> echo "a/z" > a/z
> 
> mkdir b
> echo "b/y" > b/y
> 
> mkdir c
> echo "c/z" > c/z
> 
> mkdir d
> mount --bind a d
> mount --bind --overlay b d
> mount --bind --overlay c d
> 
> cat d/x
> "a/x"
> 
> cat d/y
> "b/y"
> 
> cat d/z
> "c/z"
> 
> Then...
> 
> echo "d/w" > d/w would create a new file in directory a.
> echo "d/y" > d/y would replace the file b/y
> etc...
 
I would have expected any changes to /d/* to happen in c; as that was
the *last* change to the mount point. It would allow much niceness, like
NFS root with local changes having persistence, if you "mount -bind
-overlay <smaller local drive> /"

> Is this sort of thing possible, or are there fundamental reasons that 
> would make it difficult?

I'll leave that to greater minds then mine. :)

> Andrew
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=.wKJ4J)gXD?s3sg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+BqXsOStTnUTb5R8RAns2AJsHPsHwoV5yxgWNGB2EbnvG5EuGcACdE14i
JkYOXCRduq0Zn9AZWX76PEg=
=G0wB
-----END PGP SIGNATURE-----

--=.wKJ4J)gXD?s3sg--
