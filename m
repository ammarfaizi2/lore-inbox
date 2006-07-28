Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161390AbWG1Xvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbWG1Xvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161392AbWG1Xvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:51:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50908 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161390AbWG1Xvz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:51:55 -0400
Message-Id: <200607282351.k6SNpinN017263@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: David Miller <davem@davemloft.net>
Cc: arjan@linux.intel.com, ak@suse.de, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
In-Reply-To: Your message of "Fri, 28 Jul 2006 16:12:15 PDT."
             <20060728.161215.98863664.davem@davemloft.net>
From: Valdis.Kletnieks@vt.edu
References: <200607282045.05292.ak@suse.de> <1154112511.6416.46.camel@laptopd505.fenrus.org> <200607282305.k6SN5e0k015125@turing-police.cc.vt.edu>
            <20060728.161215.98863664.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154130703_4779P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 19:51:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154130703_4779P
Content-Type: text/plain; charset=us-ascii

On Fri, 28 Jul 2006 16:12:15 PDT, David Miller said:

> Your gcc-4.1.1 includes the -fstack-protector feature, but it might
> not have the gcc bug fix necessary to make that feature work on the
> kernel compile, which is why the version check is necessary.

Whee.  A busticated feature - how annoying.

Do you happen to know the exact PR# for that one?  Looking at the gcc RPM
changelog, there's a *lot* of backported fixes in the Fedora compiler, so it
may in fact be in there already.  I'm mentioning this mostly as a practical
"increase the number of testers" - as far as I can tell, what will ship in
Fedora Core 6 is going to call itself gcc 4.1.1, and I'm pretty sure I'm not
the only person who isn't ambitious enough to build a whole new gcc just to
test this.  So a lot of people won't be able to easily use this until FC7.

Having said that, I have *no* idea how best to code "gcc 4.2 or patched Fedora
4.1.1"...


--==_Exmh_1154130703_4779P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEyqMPcC3lWbTT17ARAui8AKC3ZQoPjsJFRN5XHTO4yRYhnDTMYQCg7+01
CYIx9zMOnQxAM/DZuLqsxsM=
=krFc
-----END PGP SIGNATURE-----

--==_Exmh_1154130703_4779P--
