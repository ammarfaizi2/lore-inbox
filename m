Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278944AbRJVVUU>; Mon, 22 Oct 2001 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278943AbRJVVUL>; Mon, 22 Oct 2001 17:20:11 -0400
Received: from cx552039-a.elcjn1.sdca.home.com ([24.177.44.17]:37823 "EHLO
	tigger.unnerving.org") by vger.kernel.org with ESMTP
	id <S278941AbRJVVUA>; Mon, 22 Oct 2001 17:20:00 -0400
Date: Mon, 22 Oct 2001 14:20:17 -0700 (PDT)
From: Gregory Ade <gkade@bigbrother.net>
X-X-Sender: <gkade@tigger.unnerving.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Mark Hahn <hahn@physics.mcmaster.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs mount of msdos fs?
In-Reply-To: <20011022163051.558d602e.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0110221417260.31371-100000@tigger.unnerving.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Well, it's a really roundabout insecure way to do it, but you might
be able to get away with sharing it via samba, mounting it on the server
and then exporting that mount via NFS....  (samba client and server and nfs
server all running on same machine).

It might work...  Actually, you can save some security hassle by making
the samba service listen on the loopback address only (127.0.0.1)...  but
then, every block of data has to go through that many more layers before
getting where it belongs...

On Mon, 22 Oct 2001, Stephan von Krawczynski wrote:

> > > I just found out, that msdos-type fs cannot be exported via nfs.
> Disregarding
> > > the security problems with msdos fs, how can I export it anyway via nfs? Is
> > > this possible at all? I tried with 2.2.19 kernel and kernel nfs.
> >
> > I'm guessing because msdos doesn't have inode numbers,
> > and nfsd wants them to make stable cookies.
>
> Works under 2.4, btw. Unfortunately I cannot use 2.4 in this special case. But
> to make it clear:
> server is 2.2.19, client is 2.4.4

- -- 
Gregory K. Ade <gkade@unnerving.org>
http://unnerving.org/~gkade
OpenPGP Key ID: EAF4844B  keyserver: pgpkeys.mit.edu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE71I2ceQUEYOr0hEsRAsFAAJ9Rs2ZJzrFrjx8D3C0T1G9o6rgDDQCgk4V/
0rQZ/YRWQ7Mw+iZ2egxdrYQ=
=SRQs
-----END PGP SIGNATURE-----


