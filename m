Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWDRXDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWDRXDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWDRXDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:03:03 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17545 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750791AbWDRXDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:03:00 -0400
Message-Id: <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Crispin Cowan <crispin@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks) 
In-Reply-To: Your message of "Tue, 18 Apr 2006 13:13:03 PDT."
             <4445484F.1050006@novell.com> 
From: Valdis.Kletnieks@vt.edu
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
            <4445484F.1050006@novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145401312_3146P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 19:01:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145401312_3146P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 Apr 2006 13:13:03 PDT, Crispin Cowan said:
> This gives the system administrator the ability to force applications to
> "drop" privs even when the application developer didn't bother, or (as
> was the case in a Sendmail vulnerability several years ago) the
> application *tried* to drop privs and got it wrong, so was running as
> full root anyway.

Interestingly enough, the Sendmail bug was a case where it was forced to "drop"
some privs, and then it didn't have enough privs to drop the rest of the privs.

In other words, it's quite possible to accidentally introduce a vulnerability
that wasn't exploitable before, by artificially restricting the privs in a way
the designer didn't expect.  So this is really just handing the sysadmin
a loaded gun and waiting.

(Incidentally, both SELinux and presumably AppArmor have the same problem - it
is really hard to convince yourself that you've identified *all* the access that
a given program needs.  People keep finding ways to excersize previously untested
code paths and error handlers, resulting in a game of whack-a-mole as the program
fails due to a lack of permissions.  This is especially fun to debug when the
program is already in an error handler... ;)


--==_Exmh_1145401312_3146P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERW/fcC3lWbTT17ARAhruAKD5PIVmZOVGogjnIBEvx6xzahGMigCdHHF4
JlFrpXkgYqlKaOKpweIutFk=
=3Uar
-----END PGP SIGNATURE-----

--==_Exmh_1145401312_3146P--
