Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266702AbUFYKn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266702AbUFYKn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUFYKn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:43:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26011 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266702AbUFYKny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:43:54 -0400
Date: Fri, 25 Jun 2004 12:43:17 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.7-mm2, mmaps rework, buggy apps, setarch
Message-ID: <20040625104317.GB20954@devserv.devel.redhat.com>
References: <20040625082243.GA11515@gamma.logic.tuwien.ac.at> <20040625013508.70e6d689.akpm@osdl.org> <20040625103326.GA21814@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20040625103326.GA21814@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



On Fri, Jun 25, 2004 at 12:33:26PM +0200, Norbert Preining wrote:
> On Fre, 25 Jun 2004, Andrew Morton wrote:
> > > But what to do with a commerical app where I
> > > cannot check a stack trace or whatever?
> > 
> > Use strace -f, look at the last screenful of output.  That usually works.
> 
> open("/media4/scan/cam-2002.03/001-100/raw/scan0100.tif", O_RDONLY) = 6
> lseek(6, 0, SEEK_END)                   = 43426634
> lseek(6, 0, SEEK_CUR)                   = 43426634
> lseek(6, 0, SEEK_SET)                   = 0
> mmap2(NULL, 43426634, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = -1 ENOMEM (Cann
> ot allocate memory)

interesting.

Could you start the binary in gdb, and then when the segfault happens, take
a snapshot of /proc/<pid>/maps of this binary ?

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA3AHExULwo51rQBIRAtEiAJ9vg6VdhF7m7gIKL2uqcZynKRBj1QCffiHl
tCd6z9gWpeOcPRdcCwagFZU=
=JrJ0
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
