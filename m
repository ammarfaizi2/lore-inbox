Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263653AbUEGQBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUEGQBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUEGQBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:01:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31198 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263654AbUEGP74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:59:56 -0400
Date: Fri, 7 May 2004 17:59:43 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Steve Lord <lord@xfs.org>
Cc: Dave Jones <davej@redhat.com>, Paul Jakma <paul@clubi.ie>,
       Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <20040507155941.GA17850@devserv.devel.redhat.com>
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org> <20040507065105.GA10600@devserv.devel.redhat.com> <20040507151317.GA15823@redhat.com> <409BAFAC.70601@xfs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <409BAFAC.70601@xfs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 07, 2004 at 10:47:56AM -0500, Steve Lord wrote:
> >-	if (mlen > sizeof(buf))
> >+	obj.data = kmalloc(1024, GFP_KERNEL);
> >+	if (!obj.data)
> >+		return -ENOMEM;
> >+
> >+	if (mlen > 1024) {
> 
> That's what I hate about all of this, just think how much stack that
> kmalloc can take in low memory situations.... it might end up in
> writepage on another nfs file....

it clearly needs to be GFP_NOFS

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAm7JtxULwo51rQBIRAoQgAJ9PQIYFry25OYd9KGC101pI5jEZ4ACfZu+4
QsloLOsOG+7deqxihbFDh4k=
=J6gx
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
