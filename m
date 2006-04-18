Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWDRClk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWDRClk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 22:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWDRClk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 22:41:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10933 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751359AbWDRClj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 22:41:39 -0400
Message-Id: <200604180238.k3I2cHmD018076@turing-police.cc.vt.edu>
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
Content-Type: multipart/signed; boundary="==_Exmh_1145327897_2737P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Apr 2006 22:38:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145327897_2737P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Apr 2006 22:26:24 BST, Alan Cox said:

> You can implement a BSD securelevel model in SELinux as far as I can see
> from looking at it, and do it better than the code today, so its not
> really a feature drop anyway just a migration away from some fossils

For a while, I had some LSM code that implemented a large chunk of the
OpenWall/PAX restrictions.  But it never stacked well with SELinux, and in
time the SELinux code got more expressive and allowed doing almost everything
that the OpenWall stuff did.

The best case I can make for it today is "somebody might want to harden the
box a little bit, but not have the resources (mostly liveware) to do SELinux".
On the other hand, that also can be read as "Cargo-cult security is better
than no security at all".

If somebody wants to carry that banner, they're welcome to it.  At this point,
I'd be willing to heave most of the LSM framework over the side as long as we
keep the right to add a new SELinux hook if we can defend its existence (see
the recent additions to allow SELinux mediation of network stuff as an example).

--==_Exmh_1145327897_2737P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERFEZcC3lWbTT17ARArn7AJ0WfAs82mMXSc14duGuJ61yHYVljgCfU/4h
axKPEhmBT0Rzacb6Sg6aueE=
=gtjz
-----END PGP SIGNATURE-----

--==_Exmh_1145327897_2737P--
