Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbUK0GbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUK0GbC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUK0G2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:28:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49599 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261891AbUKZTMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:12:37 -0500
Message-Id: <200411252234.iAPMYgoC016311@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in fs/fcntl.c 
In-Reply-To: Your message of "Tue, 23 Nov 2004 17:03:10 CST."
             <41A3C1AE.5060604@ammasso.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost> <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk> <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org> <41A38BF1.9060207@ammasso.com> <Pine.LNX.4.61.0411240003300.3389@dragon.hygekrogen.localhost>
            <41A3C1AE.5060604@ammasso.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1357138564P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Nov 2004 17:34:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1357138564P
Content-Type: text/plain; charset=us-ascii

On Tue, 23 Nov 2004 17:03:10 CST, Timur Tabi said:
> Jesper Juhl wrote:
> 
> > if pid_t is 16 bit, then the value can never be greater than 0xffff but, 
> > if pid_t is greater than 16 bit, say 32 bit, then the argument "a" could 
> > very well contain a value greater than 0xffff and then the comparison 
> > makes perfect sense.
> 
> If pid_t is 32-bit, then what's wrong with the value being greater than 
> 0xFFFF?  After all, if pid_t a 32-bit number, that implies that 32-bit 
> values are acceptable.

Try setting max_pid to 256K or so on an i386 - although the result fits
nicely in a pid_t with plenty of bits to spare, Very Bad Things happen.

Long thread starting at http://marc.theaimsgroup.com/?l=linux-kernel&m=109497978724424&w=2

--==_Exmh_1357138564P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBpl4CcC3lWbTT17ARAh4xAJ4hrHylYx9lsyJK+U3WRbJPP1TAEQCg7UWg
Yaik+XTKAfZ5ojDGBZ/v5Qw=
=E1j0
-----END PGP SIGNATURE-----

--==_Exmh_1357138564P--
