Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVBPRld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVBPRld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVBPRld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:41:33 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:41990 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262035AbVBPRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:41:24 -0500
Message-Id: <200502161741.j1GHfJ7u013810@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Lorenzo =?UNKNOWN?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       rsbac@rsbac.org,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts on the "No Linux Security Modules framework" old claims 
In-Reply-To: Your message of "Wed, 16 Feb 2005 07:52:51 PST."
             <20050216155251.16202.qmail@web50201.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050216155251.16202.qmail@web50201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108575679_12340P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Feb 2005 12:41:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108575679_12340P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Feb 2005 07:52:51 PST, Casey Schaufler said:

> The advice given by the NSA during our B1
> evaluation was that is was that in the case
> above was that the MAC check should be done
> first (because it's more important) and
> because you want the audit record to report
> the MAC failure whenever possible. The
> team advised us that if we didn't do the MAC
> check first we would have a tough row to hoe
> explaining the design decision and an even
> tougher time explaining that the audit of
> MAC criteria had been met.

Fine advice, if the LSM exits had in fact been structured that way.
But the LSM hooks are where they are, and as a result not useful for
auditing.  As others noted, the current 2.6 kernel *does* have a separate
audit framework (although it will still report DAC failures in preference
to MAC failures).

I admit having no good idea how to solve that issue, other than having the
audit framework do a dummy LSM call to see if a MAC failure would have been
reported as well if it's an audited syscall.  But that's still quite high
on the bletcherous scale....

--==_Exmh_1108575679_12340P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCE4W/cC3lWbTT17ARArRWAJ9z65SgGlW7HxcE+UgopfTsBgDNBQCfShgm
pasqOQLrKWFLBFqcgShwSSQ=
=4PsC
-----END PGP SIGNATURE-----

--==_Exmh_1108575679_12340P--
