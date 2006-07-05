Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWGECrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWGECrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 22:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWGECru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 22:47:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:34199 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932327AbWGECru (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 22:47:50 -0400
Message-Id: <200607050247.k652lkaD006629@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Petr Vandrovec <petr@vandrovec.name>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add note that lockdep is not allowed with non-GPL modules
In-Reply-To: Your message of "Tue, 04 Jul 2006 23:20:53 +0200."
             <44AADBB5.9080307@vandrovec.name>
From: Valdis.Kletnieks@vt.edu
References: <20060704202904.GA24150@vana.vc.cvut.cz> <20060704205328.GA7598@martell.zuzino.mipt.ru>
            <44AADBB5.9080307@vandrovec.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152067666_2945P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 22:47:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152067666_2945P
Content-Type: text/plain; charset=us-ascii

On Tue, 04 Jul 2006 23:20:53 +0200, Petr Vandrovec said:
> > Lock validor found a bug in NVidia driver, film at 11.

It almost certainly didn't, as you have to do some major ugly and evil
things to get the NVidia driver to build (it won't pass modpost if the
kernel is built with lockdep due to the GPL-only exports that get sucked in).

> I have no idea how NVidia managed to work around that problem, but 
> VMware modules suddenly depend on this GPL-only symbol, although nothing 
> in the module sources refers to lockdep (same sources which worked 
> yesterday are being used).

It doesn't reference it directly - it gets sucked in via a #define.


--==_Exmh_1152067666_2945P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFEqyhRcC3lWbTT17ARAje5AJjE6TxT7Gr84wuWX+ypLrfAdAdzAJ0QUXZK
sBnEj/dm7MGRdqIjHt160Q==
=I7vt
-----END PGP SIGNATURE-----

--==_Exmh_1152067666_2945P--
