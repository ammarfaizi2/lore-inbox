Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTIAXwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 19:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTIAXwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 19:52:49 -0400
Received: from h80ad2572.async.vt.edu ([128.173.37.114]:12672 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263349AbTIAXwr (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 19:52:47 -0400
Message-Id: <200309012352.h81NqXT9006422@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: azarah@gentoo.org
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>, Andrew Morton <akpm@osdl.org>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4-mm3 
In-Reply-To: Your message of "Mon, 01 Sep 2003 22:23:30 +0200."
             <1062447809.5275.7.camel@nosferatu.lan> 
From: Valdis.Kletnieks@vt.edu
References: <3F4F22D3.9080104@freemail.hu> <200308291300.h7TD049n022785@turing-police.cc.vt.edu> <1062168946.19599.114.camel@workshop.saharacpt.lan> <200308291553.h7TFrcGG009390@turing-police.cc.vt.edu>
            <1062447809.5275.7.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1045128769P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 01 Sep 2003 19:52:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1045128769P
Content-Type: text/plain; charset=us-ascii

On Mon, 01 Sep 2003 22:23:30 +0200, Martin Schlemmer said:

> > +		if ! $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE
)   ; t=
> hen \
> > +			echo "*** Depmod failed!!!"; \
> > +			echo "*** You may need to install a current version of 
module-init-to=
> ols"; \
> > +			echo "*** See http://www.codemonkey.org.uk/post-hallowe
en-2.5.txt"; \
> > +			exit 1; \
> > +	 	fi \
> > +	fi
> > =20
> >  else # CONFIG_MODULES
> 
> Hmm, this will only work with RH based systems (not using here).  I
> think the best way is how Andrew did it to just warn if depmod fails.
> You may agree to disagree if need be :)

Umm.. how will this fail for *any* system that has a sane 'depmod' (sane as in
"calls exit(0) if it worked"?  In this patch we never actually check the
version - we just add code that "if depmod fails during 'make install_modules',
it may be too old and give them a hint".

(Incidentally, I tested it with the RH9 depmod, the Rusty depmod,  and the
Rawhide depmod - for Rusty and Rawhide it was silent, the older RH9 depmod
barfed and then gave the hint...)


--==_Exmh_-1045128769P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/U9vBcC3lWbTT17ARAuReAKC5CoWY6euEcUa5wRrum1rKfGynRQCgssFG
C38KE6n4B32zMXrVk1YTLA0=
=ykN6
-----END PGP SIGNATURE-----

--==_Exmh_-1045128769P--
