Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTLAA6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 19:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTLAA6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 19:58:13 -0500
Received: from h80ad2462.async.vt.edu ([128.173.36.98]:56488 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262569AbTLAA6M (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 19:58:12 -0500
Message-Id: <200312010057.hB10vm02008624@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: john smith <john.smith77@gmx.net>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel modul licensing issues 
In-Reply-To: Your message of "Mon, 01 Dec 2003 01:27:58 +0100."
             <21620.1070238478@www5.gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <21620.1070238478@www5.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1934712984P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Nov 2003 19:57:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1934712984P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 01 Dec 2003 01:27:58 +0100, john smith said:

> Well, the algorithm has been developped totally independent from
> linux. It also works under other OS's without any adjustments apart
> from alloc and locking stuff.
> =

> The fact that it receives kernel data as input IMO does not make it
> tightly coupled to the linux kernel since the algorithm does not even
> know or care what it receives as input (at least as far as kernel data
> is concerned). It basically considers kernel data: char[]

You're probably "in the clear" if that's what's really going on, and
can probably go a route similar to NVidia (GPL interface to a binary
module).  The part I'm not having warm fuzzies about is that the only
application that comes to mind that could take a char[] and be totally
kernel-independent and that would make sense in the kernel rather than
out in userspace is a crypto transform - and that's because closed
source crypto is usually not taken seriously.

Consider what Matt Blaze did to Clipper, which was even more closed
source than what you're doing....  Of course, if you're not doing
crypto, then you can apply the usual cost/benefit analysis of doing
it closed source versus the payoff for an attacker to crack it....

--==_Exmh_-1934712984P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ypIMcC3lWbTT17ARAlxGAJ9YlYrbIvsqIPb8FY6+u/iTu9KODgCfRG1a
IWT4N/2NFAP5IhNB0UldMPA=
=S7eq
-----END PGP SIGNATURE-----

--==_Exmh_-1934712984P--
