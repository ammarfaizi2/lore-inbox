Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTEIH3q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTEIH3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:29:46 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:23227 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262336AbTEIH3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:29:44 -0400
Date: Fri, 9 May 2003 10:42:08 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Christoph Hellwig <hch@infradead.org>, Shachar Shemesh <lkml@shemesh.biz>,
       Terje Eggestad <terje.eggestad@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509074208.GA14991@actcom.co.il>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com> <1052398474.4849.57.camel@pc-16.office.scali.no> <20030508135839.A6698@infradead.org> <3EBAAB9D.5000508@shemesh.biz> <20030508201509.A19496@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20030508201509.A19496@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2003 at 08:15:09PM +0100, Christoph Hellwig wrote:

> No, the most important point is that a proper meachanism wouldn't
> replace syscall slots but rather operate on kernel objects (file, inode
> vma, task_struct, etc..).  Linus has expressed a few times that
> he has no interest in loadable syscalls and any core developer I've
> talked to agrees with that.

For some usages, hijacking syscalls, and not kernel objects, is the
desired outcome. For example, ptrace is great for telling you what a
given process (or its children) did, but it's entirely inadequate for
telling you *which* process did something. Something, in this case,
which doesn't have an associated kernel object.=20

For example, a rogue process is calling settimeofday() on your router
once a month(!). How are you going to find it? There's no LSM hook for
settimeofday() or any other way to say "don't do that", if it's
running as root. Using syscalltrack, or anything else which hijacks
system calls, not just kernel object, finding the culprit is trivial.=20

I've been staying out of this discussion, even though I have an
interest in its outcome. Talking about it is completely pointless
until someone writes a proper, *technically correct*, system call
hijacking interface. Then we can argue about whether or not it should
go in.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+u1vPKRs727/VN8sRAhTNAKCAg8zwLSnbN1Ri4Adz+0bZBWbGfgCfV39K
akQl5FSYDru8QNAB66wzc94=
=Oh/k
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
