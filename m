Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSH0A2r>; Mon, 26 Aug 2002 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318308AbSH0A2r>; Mon, 26 Aug 2002 20:28:47 -0400
Received: from ppp-217-133-216-55.dialup.tiscali.it ([217.133.216.55]:8590
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318305AbSH0A2q>; Mon, 26 Aug 2002 20:28:46 -0400
Subject: Re: problems with changing UID/GID
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Zheng Jian-Ming <zjm@cis.nctu.edu.tw>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm> 
	<1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-tKi4GcZpcNZlPMdcAiOr"
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 Aug 2002 20:49:19 +0200
Message-Id: <1030387759.1488.22.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tKi4GcZpcNZlPMdcAiOr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-08-26 at 19:16, Alan Cox wrote:
> On Mon, 2002-08-26 at 15:58, Thunder from the hill wrote:
> > I personally like the task->cred->cr_uid, etc. approach. Helps a lot.
> 
> It changes the whole semantics of every security test in Linux, and
> breaks most of them totally. Our syscalls know the uid is constant
> during the call
This is easily fixable by having a shared structure separate from the
private one and propagating modifications only when entering kernel
mode.
If we combine the syscall-trace and cred-propagation checks this can be
done without overhead in the common case (but needs care to avoid
races).

This is similar to what user space would do but faster and transparent.

(BTW, I don't plan to code this myself)


--=-tKi4GcZpcNZlPMdcAiOr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9angvdjkty3ft5+cRArs6AJ0bk2IqvW6Qbw/dT6Jp/tRPvYxkPgCeMDRU
NkB6nvubq2qALgBUuhDOmrs=
=t6Yb
-----END PGP SIGNATURE-----

--=-tKi4GcZpcNZlPMdcAiOr--
