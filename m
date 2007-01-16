Return-Path: <linux-kernel-owner+w=401wt.eu-S1751238AbXAPPPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbXAPPPp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 10:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbXAPPPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 10:15:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56996 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbXAPPPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 10:15:44 -0500
Message-ID: <45ACEBDF.60602@redhat.com>
Date: Tue, 16 Jan 2007 07:14:39 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Pierre Peiffer <pierre.peiffer@bull.net>
CC: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
References: <45A3BFAC.1030700@bull.net> <45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org> <45A73E90.7050805@bull.net> <20070112075816.GA23341@elte.hu> <45AC8E2A.3060708@bull.net>
In-Reply-To: <45AC8E2A.3060708@bull.net>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBA9A568BF06096F3868F137E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBA9A568BF06096F3868F137E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pierre Peiffer wrote:
> I've run this bench 1000 times with pipe and 800 groups.
> Here are the results:

This is not what I'm mostly concerned about.  The patches create a
bottleneck since _all_ processes use the same resource.  Plus, this code
has to be run on a machine with multiple processors to get RFOs into play=
=2E

So, please do this: on an SMP (4p or more) machine, rig the test so that
it runs quite a while.  Then, in a script, start the program a bunch of
times, all in parallel.  Have the script wait until all program runs are
done and time the time until the last program finishes.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigBA9A568BF06096F3868F137E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFrOvf2ijCOnn/RHQRArOMAKCZyFz6o28umdXWl0+hthdG4tjSdQCgnSHJ
tpG2iLFITS52rEMwtoSwQ2w=
=LVdC
-----END PGP SIGNATURE-----

--------------enigBA9A568BF06096F3868F137E--
