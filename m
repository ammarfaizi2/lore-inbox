Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWDWJfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDWJfI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 05:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWDWJfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 05:35:08 -0400
Received: from h80ad249d.async.vt.edu ([128.173.36.157]:6371 "EHLO
	h80ad249d.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751016AbWDWJfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 05:35:06 -0400
Message-Id: <200604230933.k3N9XTZ8019756@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Crispin Cowan <crispin@novell.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks) 
In-Reply-To: Your message of "Sat, 22 Apr 2006 20:50:15 PDT."
             <444AF977.5050201@novell.com> 
From: Valdis.Kletnieks@vt.edu
References: <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <20060420211308.GB2360@ucw.cz>
            <444AF977.5050201@novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145784808_3800P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Apr 2006 05:33:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145784808_3800P
Content-Type: text/plain; charset=us-ascii

On Sat, 22 Apr 2006 20:50:15 PDT, Crispin Cowan said:
>> What happens if I ln /bin/stty /tmp/evilstty, then exploit
>> vulnerability in stty? 

A crucial point here is that the 'ln' and the actual exploit don't
have to be firmly attached to each other...

If you can get *any* unconfined user to do that 'ln' (Hmm... have you checked if
your tar/cpio/pax/etc have been patched to prohibit this when you extract an
archive?), then the exploit can be run *even in a domain that can't do the ln
that set it up*.

> This is a really basic misunderstanding of AppArmor. All unconfined
> processes are considered trusted, so attacks that suppose an unconfined
> user did something very evil/stupid are not interesting.

Unfortunately, in the *real* world, "unconfined user accidentally runs
malware that sets up the conditions for a later exploit" is an actual
real problem.  I'm sorry to see that it's just swept under the rug as
"not interesting".

Now, if you changed "not interesting" to "so damned hard we couldn't figure
out how to deal with it", I'd have a bit of sympathy for the position... ;)


--==_Exmh_1145784808_3800P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFES0nocC3lWbTT17ARAhGKAKDzzdORpAMtb4YcEhIpoqSqqjbr1gCeN74a
OgIEDYG+nfjxwVNmCAoYQ/o=
=nnq3
-----END PGP SIGNATURE-----

--==_Exmh_1145784808_3800P--
