Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWDRCdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWDRCdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 22:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWDRCdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 22:33:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36016 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932155AbWDRCdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 22:33:42 -0400
Message-Id: <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks) 
In-Reply-To: Your message of "Mon, 17 Apr 2006 22:26:24 BST."
             <1145309184.14497.1.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com>
            <1145309184.14497.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145327373_2737P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Apr 2006 22:29:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145327373_2737P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Apr 2006 22:26:24 BST, Alan Cox said:

(Two replies to this paragraph, addressing 2 separate issues....)

> You can implement a BSD securelevel model in SELinux as far as I can see
> from looking at it, and do it better than the code today, so its not
> really a feature drop anyway just a migration away from some fossils

If we heave the LSM stuff overboard, there's one thing that *will* need
addressing - what to do with kernel support of Posix-y capabilities.  Currently
some of the heavy lifting is done by security/commoncap.c.

Frankly, that's *another* thing that we need to either *fix* so it works right,
or rip out of the kernel entirely.  As far as I know, there's no in-tree way
to make /usr/bin/ping be set-CAP_NET_RAW and have it DTRT.

--==_Exmh_1145327373_2737P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERE8NcC3lWbTT17ARAi8yAJ0eavgSemxTFEaqS8OghD52mm0DRwCeJnn9
3pXm11aKdYaFNreK4tgyCaQ=
=XRMO
-----END PGP SIGNATURE-----

--==_Exmh_1145327373_2737P--
