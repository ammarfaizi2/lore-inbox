Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUCMTlS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbUCMTlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:41:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263174AbUCMTlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:41:11 -0500
Date: Sat, 13 Mar 2004 20:38:52 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: John Reiser <jreiser@BitWagon.com>
Cc: Micha Feigin <michf@post.tau.ac.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040313193852.GC12292@devserv.devel.redhat.com>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <4053624D.6080806@BitWagon.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 13, 2004 at 11:34:37AM -0800, John Reiser wrote:
> Arjan van de Ven wrote:
> >On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> >
> >>Is it possible to find out what the kernel's notion of HZ is from user
> >>space?
> >>It seem to change from system to system and between 2.4 (100 on i386)
> >>to 2.6 (1000 on i386).
> >
> >
> >if you can see 1000 from userspace that is a bad kernel bug; can you say
> >where you find something in units of 1000 ?
> 
> create_elf_tables() in fs/binfmt_elf.c tells every ELF execve():
>         NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
> which can be found by crawling through the stack above the pointer
> to the last environment variable.

Ugh that should say 100 on x86....
but..
param.h:# define USER_HZ        100             /* .. some user interfaces are in "ticks" */
param.h:# define CLOCKS_PER_SEC (USER_HZ)       /* like times() */
.....
that looks like 100 to me.


--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAU2NLxULwo51rQBIRAlF6AJ9gFounWM3a+Fdd6y6dhcIIHubYXQCfdOhe
Ug+1J2lDx4NlB4Juk53hxp0=
=3PSQ
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
