Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbUK2KTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUK2KTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbUK2KT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:19:29 -0500
Received: from grendel.firewall.com ([66.28.58.176]:44988 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261649AbUK2KTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:19:24 -0500
Date: Mon, 29 Nov 2004 11:19:19 +0100
From: Marek Habersack <grendel@caudium.net>
To: linux-kernel@vger.kernel.org
Subject: user- vs kernel-level resource sandbox for Linux?
Message-ID: <20041129101919.GB9419@beowulf.thanes.org>
Reply-To: grendel@caudium.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

  I am looking for advice on how to limit resource (memory in particular)
usage on a linux machine (running either kernel v2.4 or2.6) on the per-user
(vs per-process) basis. I am aware that I could use Xen or UML for that
purpose, but I am wondering whether anybody knows any solution that can
implement that entirely in the userland (e.g. a monitor application that
intercepts system calls responsible for resource allocation and controls the
memory usage that way). My problem is apache which spawns a certain process
on which sometimes runs away and causes the kernel to kill apache, the
offending process and cause all fork(2) attempts to fail (which effectively
disables ssh). I've tried limiting resources on the apache startup, but that
isn't of much help since each apache process will get the same resources and
it's enough that several of them allocate too much memory at the same time
and the effect is as described above. I've also played with overcommit on
the 2.6 kernel in hope that it will stop the process from allocating
excessive amounts of memory, but it wasn't of much help either, alas...
  I would appreciate any pointers to the userland solutions for that problem
(if any exist) before I resort to Xen/UML.

  thanks in advance,

marek

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBqvenq3909GIf5uoRAjNOAJ43H8B3qfdn0miTZv5R5xOZL2oYgwCfaBQm
ytYd7X1IqVPGW4HTojd219w=
=iy73
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
