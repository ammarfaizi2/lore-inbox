Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293467AbSCPCkd>; Fri, 15 Mar 2002 21:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293675AbSCPCkY>; Fri, 15 Mar 2002 21:40:24 -0500
Received: from codepoet.org ([166.70.14.212]:34466 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S293467AbSCPCkN>;
	Fri, 15 Mar 2002 21:40:13 -0500
Date: Fri, 15 Mar 2002 19:40:13 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Dan Kegel <dank@ixiacom.com>, linux-kernel@vger.kernel.org
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem  (one li\ne)>
Message-ID: <20020316024012.GB14642@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Ulrich Drepper <drepper@redhat.com>, Dan Kegel <dank@ixiacom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet> <3C8FEC76.F1411739@ixiacom.com> <20020314020834.Z2434@devserv.devel.redhat.com> <3C926E0B.1A0EE311@ixiacom.com> <1016237961.5612.51.camel@myware.mynet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <1016237961.5612.51.camel@myware.mynet>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri Mar 15, 2002 at 04:19:17PM -0800, Ulrich Drepper wrote:
> On Fri, 2002-03-15 at 13:56, Dan Kegel wrote:
>=20
> > Ulrich, do you at least agree that it would be desirable for
> > gprof to work properly on multithreaded programs?
>=20
> No.  gprof is uselss in today world.

Then why not change sysdeps/generic/initfini.c with something like:

-      if (gmon_start)
+      if (gmon_start && __pthread_initialize_minimal)
          gmon_start ();

So it doesn't even try when threading?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8krCMX5tkPjDTkFcRAlIKAJsEoltsoMNVBkGYLUyzbMD99X7lUACeOo8C
e7pPN7d6T+MHghMOsZWGgNg=
=LOyx
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
