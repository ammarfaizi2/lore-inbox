Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270169AbTGZPLg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272540AbTGZPIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:08:36 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:58271 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S270142AbTGZPGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:06:02 -0400
Date: Sat, 26 Jul 2003 16:19:56 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Meelis Roos <mroos@math.ut.ee>, lkml <linux-kernel@vger.kernel.org>,
       neilb@cse.unsw.edu.au
Subject: Re: NFS server broken in 2.4.22-pre6?
Message-ID: <20030726151956.GA11253@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Meelis Roos <mroos@math.ut.ee>, lkml <linux-kernel@vger.kernel.org>,
	neilb@cse.unsw.edu.au
References: <Pine.GSO.4.44.0307242023530.5806-100000@math.ut.ee> <Pine.LNX.4.55L.0307251001480.12492@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307251001480.12492@freak.distro.conectiva>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nick: darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2003 at 10:05:33AM -0300, Marcelo Tosatti wrote:
> 
> 
> On Thu, 24 Jul 2003, Meelis Roos wrote:
> 
> > NFS serving seems to be broken in 2.4.22-pre6. I had 2 computers running
> > 2.4.22-pre6 (x86, debian unstable current). Tried to acces them via NFS
> > (using am-utils actually) from a 3rd computer, IO error. Tried to
> > mount directly, mount: RPC: timed out. Rebooted one computer to 2.4.18
> > and NFS started to work.
> >
> > No more details currently but I can test more thoroughly tomorrow.
> 
> Meelis,
> 
> Please report more details.

   I'm also having trouble with NFS, with a 2.4.22-pre6-ac1 server.

   I'm booting a diskless workstation (with a 2.4.21-ac1 client), and
it will boot and mount the root filesystem. When I try to mount any
other filesystems, the client reports

mount: can't get address for vlad

and loses the main NFS mount: attempts to access any file on the root
filesystem gives stale NFS file handle errors. The failure to mount
also breaks the server -- I can no longer boot the diskless client.
Restarting the NFS server allows me to boot the client once again.

   Like Meelis, I'm also using Debian unstable, and I've tried with
both the 1.0.3-1 and 1.0.5 versions of the nfs-tools on both machines.
Both versions give the same error that I reported above.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
       --- "Are you the man who rules the Universe?" "Well,  I ---       
                              try not to."                               

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IpwbssJ7whwzWGARAu37AJ4lMftyvGgaRCGT7jS7ZFlYCtDukQCdFJ3j
sAlGqaiGYWLlT16ndRelbh8=
=zppx
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
