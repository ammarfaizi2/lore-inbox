Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272909AbTHKS2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272961AbTHKS2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:28:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:58240 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S272919AbTHKS1v (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:27:51 -0400
Message-Id: <200308111827.h7BIRm0r031760@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SE Linux as module? 
In-Reply-To: Your message of "Mon, 11 Aug 2003 21:25:04 +0400."
             <200308112125.04257.arvidjaar@mail.ru> 
From: Valdis.Kletnieks@vt.edu
References: <200308112125.04257.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-644031152P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Aug 2003 14:27:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-644031152P
Content-Type: text/plain; charset=us-ascii

On Mon, 11 Aug 2003 21:25:04 +0400, Andrey Borzenkov <arvidjaar@mail.ru>  said:
> config does not suggest building it as module. Is it not possible by design?

It wants to initialize itself as early as possible.  If it's a module, then it
can't get itself loaded until *after* userspace has already been started - at
which point we have some unknown number of things already running that don't
have any security context attached to them.  Yes, you still need to load policy
from userspace, but at least every process has been tagged with a "yes, we know
about it".  In addition, if you're loading from userspace, that's a whole
additional set of attacks on it during the bot (for instance, keeping the
insmod from running at all, inserting a trojaned module or policy, etc etc
etc...)


--==_Exmh_-644031152P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/N+AkcC3lWbTT17ARAgWfAKC799/hYP7+T3TdrNapgnwcoMC2ygCgq0d1
qmTCmJXo9ZHMLQmal2lpXBc=
=vMnc
-----END PGP SIGNATURE-----

--==_Exmh_-644031152P--
