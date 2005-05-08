Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbVEHQWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVEHQWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 12:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVEHQWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 12:22:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:46570 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262892AbVEHQWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 12:22:24 -0400
X-Authenticated: #153925
From: Bernd Paysan <bernd.paysan@gmx.de>
To: suse-amd64@suse.com
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Date: Sun, 8 May 2005 18:22:20 +0200
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200505081445.26663.bernd.paysan@gmx.de> <20050508134035.GC15724@wotan.suse.de>
In-Reply-To: <20050508134035.GC15724@wotan.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2072349.kILzOkktL3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505081822.21304.bernd.paysan@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2072349.kILzOkktL3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 08 May 2005 15:40, Andi Kleen wrote:
> Your system should be using the HPET timer to work exactly around
> this. AMD 8000 has HPET. Can you post a boot.log?

Will come tomorrow - I don't sit right at the machine, and while trying=20
to figure out what happens, I accidentally shut it down or caused it to=20
crash (I can't log in remotely ATM).

> The current design is that only the BP runs the main timer, and the
> other CPUs use the APIC timer and don't do any own time keeping. I
> think you misread the code quite a bit.
>=20
> And lost jiffie handling can't be dropped no.
>
> A common problem however is that the irq 0 is misrouted somehow,
> and gets broadcasted and processed on multiple CPUs. That results
> in the time running far too fast. You can check that by looking
> at /proc/interrupts.

Yes, that's sort of what's happening. /proc/interrupts shows that all=20
CPUs overall get an even share of IRQ 0 - but each IRQ0 is processed by=20
just one CPU. How can I examine and set the interrupt routing?

=2D-=20
Bernd Paysan
"If you want it done right, you have to do it yourself"
http://www.jwdt.com/~paysan/

--nextPart2072349.kILzOkktL3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCfjy9i4ILt2cAfDARAnEmAJ9lOSgfAYI74+Ho3YjPfoOLTPqoSwCglsYT
UywxSkYwdCUTJsykgC67gPs=
=fsAY
-----END PGP SIGNATURE-----

--nextPart2072349.kILzOkktL3--
