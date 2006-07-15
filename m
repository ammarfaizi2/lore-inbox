Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWGORqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWGORqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 13:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWGORqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 13:46:10 -0400
Received: from mail.gmx.net ([213.165.64.21]:6079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750726AbWGORqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 13:46:09 -0400
X-Authenticated: #5082238
Date: Sat, 15 Jul 2006 19:45:57 +0200
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Very poor IO performance (high CPU load), libata
Message-ID: <20060715174555.GA27640@server.c-otto.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello (again)!

System specs below.

My system sometimes[1] crashes in the sense that every HDD access is slow
as hell and most of both CPUs' power is used for IO waiting. Then "top"
shows more than 80% "wa" and the corresponding counter in /proc/stat
increases a lot. When plotting these values with rrdtool I see up to 5%
IO wait with normal behaviour and peaks with up to 40% under heavy load.

In the problem case the IO wait never drops below 40% no matter how light
the HDD load is. Logging in into the system via SSH then takes more than
two minutes and other tasks are equally slow.

Disabling AHCI/ACPI/SMP in the kernel did not help.
I also tried several kernel versions including 2.6.16 to 2.6.18 (rc,
mm).

/proc/interrupts shows a lot of interrupts for my network cards, but
disabling the network does not solve the problem.

A reboot usually solves the problem for some time.

There might be a problem with my hardware (in a not yet determined
device) causing this problem. But as long as I do not know what is wrong
I still see the chance of a software error in the kernel.

System specs:
- Mainboard with Intel 945p and iCH7R (Foxconn 945P7AA-8EKRS2)
- Intel Pentium D 805 (Dual Core, 2.66 GHz, 1 MB cache each)
- 4x Maxtor MaXLine III (300GB, 16MB Cache, SATA2)

[1] Sometimes: More than daily, at the moment I am lucky and noticed no
problem for hours.

Thanks a lot,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEuSnTjUF4jpCSQBQRAoi5AKChMpXiLfXY04Qf26LTDfTTuC8kYwCcDpaF
ZS4fK2/IygYOxMLzNzgc4J8=
=m8f9
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
