Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUADXo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbUADXo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:44:27 -0500
Received: from h80ad253c.async.vt.edu ([128.173.37.60]:32432 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265794AbUADXo0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:44:26 -0500
Message-Id: <200401042344.i04NiNGa030175@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Willy Tarreau <willy@w.ods.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?! 
In-Reply-To: Your message of "Mon, 05 Jan 2004 00:33:12 +0100."
             <20040104233312.GA649@alpha.home.local> 
From: Valdis.Kletnieks@vt.edu
References: <1073227359.6075.284.camel@nosferatu.lan> <20040104225827.39142.qmail@web40613.mail.yahoo.com>
            <20040104233312.GA649@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1616797654P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jan 2004 18:44:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1616797654P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Jan 2004 00:33:12 +0100, Willy Tarreau said:

> at a time. I have yet to understand why 'ls|cat' behaves
> differently, but fortunately it works and it has already saved

I suspect that ls and cat do different buffering to their outputs, and/or the
fact there's now 4 processes (ls, cat, xterm, Xserver) rather than just 3.  End
result is that things wake up in a different order and happen to schedule
better. (For instance, ls may be able to make progress while cat is blocked
waiting for the xterm to read the next block, etc).  I remember at least some
versions of 'dd' would fork off a sub-process so there would be a reader side
and a writer side with a shared memory buffer, for just that reason.


--==_Exmh_1616797654P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+KVXcC3lWbTT17ARAn4hAKCszxRCfT3fFs7oQk9CYD7UYCUztgCgo0z0
xgHik6WOH9hj1GlUBVzDj+Y=
=5Mvz
-----END PGP SIGNATURE-----

--==_Exmh_1616797654P--
