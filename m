Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbUCPGla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 01:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbUCPGla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 01:41:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263465AbUCPGl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 01:41:28 -0500
Date: Tue, 16 Mar 2004 07:33:31 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Peter Williams <peterw@aurema.com>
Cc: John Reiser <jreiser@BitWagon.com>, Micha Feigin <michf@post.tau.ac.il>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040316063331.GB23988@devserv.devel.redhat.com>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <40564A22.5000504@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 16, 2004 at 11:28:18AM +1100, Peter Williams wrote:
> >Ugh that should say 100 on x86....
> >but..
> >param.h:# define USER_HZ        100             /* .. some user interfaces 
> >are in "ticks" */
> >param.h:# define CLOCKS_PER_SEC (USER_HZ)       /* like times() */
> >.....
> >that looks like 100 to me.
> >
> 
> This horrible hack of converting all tick values to 100 (from 1000) for 
> export to user space because a large number of user space programs 
> assume that HZ is 100 would NOT be necessary if there was a mechanism 
> whereby user space programs could find out how many ticks there are in a 
> second instead of having to make assumptions.

there is one. Nothing uses it
(sysconf() provides this info)


--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAVp+6xULwo51rQBIRAk8sAKCTsc9CNbTYxJ40EKvT4gYini9XuwCfUbGM
jxOj8sI9dDkFDGcXc45ANp8=
=Kpna
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
