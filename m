Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTJ1Qbc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbTJ1Qbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:31:32 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:38610 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S264027AbTJ1Qbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:31:31 -0500
Date: Tue, 28 Oct 2003 11:31:25 -0500
From: Georg Nikodym <georgn@somanetworks.com>
To: Peter Berg Larsen <pebl@math.ku.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: weird mouse movement in 2.6.0-test9
Message-Id: <20031028113125.5e98b7ed.georgn@somanetworks.com>
In-Reply-To: <Pine.LNX.4.40.0310281548340.7187-100000@shannon.math.ku.dk>
References: <20031028093237.65d7c8f2.georgn@somanetworks.com>
	<Pine.LNX.4.40.0310281548340.7187-100000@shannon.math.ku.dk>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__28_Oct_2003_11_31_25_-0500_EVwMRJgeIZJUx+bZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__28_Oct_2003_11_31_25_-0500_EVwMRJgeIZJUx+bZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2003 15:58:26 +0100 (CET)
Peter Berg Larsen <pebl@math.ku.dk> wrote:


> I have seen this on my i8k since bios a18. The stick generates random
> moves and clicks when I press and hold a key. (The moves/clicks are
> indistiguishable from real stick usage)

Mmm.  Seems you're right.

So I grabbed the latest synaptics stuff (from a couple of days ago) and
updated my XF86Config-4.  There I discovered that I am not crazy just
stupid.

I had an (InputDevice) entry looking at /dev/input/mice, another one
looking at /dev/input/eventX and a third looking at /dev/psaux. Removing
the cruft and updating the synaptics entry has fixed my problem.

Sorry for the noise.

-g

--Signature=_Tue__28_Oct_2003_11_31_25_-0500_EVwMRJgeIZJUx+bZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/npngoJNnikTddkMRAscQAKCiJsFFrV4eplrwdybvpbyYnmeUgACgqwPb
Qxfi9CK6+JuitHm8ABmRpac=
=v5E8
-----END PGP SIGNATURE-----

--Signature=_Tue__28_Oct_2003_11_31_25_-0500_EVwMRJgeIZJUx+bZ--
