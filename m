Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbWJ2Qji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbWJ2Qji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 11:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWJ2Qji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 11:39:38 -0500
Received: from pool-72-66-199-112.ronkva.east.verizon.net ([72.66.199.112]:55237
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965286AbWJ2Qjh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 11:39:37 -0500
Message-Id: <200610291639.k9TGdV6E011416@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: predator@mt9.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: -W -Wno-unused -Wno-sign-compare compile flags
In-Reply-To: Your message of "Sun, 29 Oct 2006 17:22:48 +0300."
             <web-577743@televic-cs.ru>
From: Valdis.Kletnieks@vt.edu
References: <web-577743@televic-cs.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1162139970_6875P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 29 Oct 2006 11:39:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1162139970_6875P
Content-Type: text/plain; charset=us-ascii

On Sun, 29 Oct 2006 17:22:48 +0300, predator@mt9.ru said:
> Hello !linux-kernel
> 
> Does anybody try to compile latest linux-kernel with -W 
> -Wno-unused -Wno-sign-compare CFLAGS? There is a tons of 
> warnings :(
> Recent versions of grsecurity patches adds this flags to 
> default. When I asked to grsec developers, why did they do 
> that, they answered: to show, how messy linux code is...
> Is there any objections about it?

I'd recommend attacking this one flag at a time - so for instance,
do up a series of patches that cleans up the -Wno-unused warnings, and
get that merged.  Then get a series for -Wno-sign-compare, and finally
a patch that adds -W.

While you're at it, look at these flags as well:

-Werror-implicit-function-declaration -Wcomment -Wendif-labels -Wshadow

(The tree is pretty clean for the first 3, cleaning it for the last will
take some work...)

--==_Exmh_1162139970_6875P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFRNlCcC3lWbTT17ARAuRyAKCMQUxLpFsykgXYwzq2sg5ADwlEEQCgjGPZ
oRUXxpSemLClXkT1eGtfsAE=
=rZGd
-----END PGP SIGNATURE-----

--==_Exmh_1162139970_6875P--
