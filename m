Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWFQOQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWFQOQN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 10:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWFQOQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 10:16:13 -0400
Received: from hosting-agency.de ([194.145.226.10]:63880 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S1751379AbWFQOQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 10:16:12 -0400
From: Simon Raffeiner <sturmflut@lieberbiber.de>
Reply-To: sturmflut@lieberbiber.de
Organization: Lieberbiber, Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] vdso: improve print_fatal_signals support by adding memory maps
Date: Sat, 17 Jun 2006 16:14:52 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1476471.1z3goRNOgM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606171614.58610.sturmflut@lieberbiber.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1476471.1z3goRNOgM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When compiling 2.6.17-rc6-mm2 (which contains this patch) my gcc 4.0.3 (Ubu=
ntu=20
4.0.3-1ubuntu5) complains about "int len;" being used uninitialized in=20
print_vma(). AFAICS len is not initialized and then passed to=20
pad_len_spaces(int len), which uses it for some calculations.

I also noticed that similar code is used in fs/proc/task_mmu.c, where=20
show_map_internal() passes an uninitialised int len; to pad_len_spaces(stru=
ct=20
seq_file *m, int len).


Please include my E-Mail address in replies as I am not subscribed to LKML.

=2D-=20
OpenPGP/GnuPG Key: 0xB2204FA0 @ subkeys.pgp.net

"There is no point in having Linux on the Desktop if it's at the cost of it=
=20
being the same crap that Windows is."
  - Benjamin Herrenschmidt

--nextPart1476471.1z3goRNOgM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBElA5id2q78rIgT6ARAsXVAJsGhwrD9CQWw2/8vgGa0t53uMKemgCfc6uT
cOD3zNKHdV1JKwOPFWAsFso=
=0apQ
-----END PGP SIGNATURE-----

--nextPart1476471.1z3goRNOgM--
