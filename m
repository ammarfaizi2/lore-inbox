Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUGQXH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUGQXH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUGQXEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 19:04:54 -0400
Received: from smtp.gentoo.org ([156.56.111.197]:19163 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262328AbUGQWj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:39:27 -0400
Date: Sat, 17 Jul 2004 23:36:54 +0100
From: Ciaran McCreesh <ciaranm@gentoo.org>
To: augustus@linuxhardware.org
Cc: linux-kernel@vger.kernel.org, tseng@gentoo.org,
       jnagyjr@joseph-a-nagy-jr.homelinux.org
Subject: Re: vim doesn't like the command line
Message-Id: <20040717233654.102579e1@snowdrop.home>
In-Reply-To: <Pine.LNX.4.58.0407142340560.7017@penguin.linuxhardware.org>
References: <Pine.LNX.4.58.0407142340560.7017@penguin.linuxhardware.org>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__17_Jul_2004_23_36_54_+0100_1.Va.6Mvb1lZy/M/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__17_Jul_2004_23_36_54_+0100_1.Va.6Mvb1lZy/M/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 14 Jul 2004 23:44:16 -0400 (EDT) augustus@linuxhardware.org
wrote:
| This is odd but it seems that vim 6.3 does not function properly with 
| kernel 2.6.8-rc1.  It will not take command line arguement filenames. 
| No matter what you pass it, it always goes to the file browser.  This
| is not the case with 2.6.7 kernels.  Any ideas?  I have attached my
| kernel .config.

I've been trying to track this down as well. Kinda tricky, since it
WORKSFORME(TM). The following may be of help to you:

http://bugs.gentoo.org/show_bug.cgi?id=57378

Basically, argv is getting nuked by something.

Seems rebuilding without a -march in CFLAGS fixes it for some people,
reason unknown...

-- 
Ciaran McCreesh : Gentoo Developer (Sparc, MIPS, Vim, Fluxbox)
Mail            : ciaranm at gentoo.org
Web             : http://dev.gentoo.org/~ciaranm


--Signature=_Sat__17_Jul_2004_23_36_54_+0100_1.Va.6Mvb1lZy/M/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+aoN96zL6DUtXhERAif+AJ0W6U9ajVQPHPLSW4P02gLwISaBZwCeMgK+
sTi/pL+gSBostwCUsdTr5u4=
=wvyE
-----END PGP SIGNATURE-----

--Signature=_Sat__17_Jul_2004_23_36_54_+0100_1.Va.6Mvb1lZy/M/--
