Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWDSGuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWDSGuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 02:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWDSGuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 02:50:16 -0400
Received: from ns1.suse.de ([195.135.220.2]:30686 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750809AbWDSGuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 02:50:14 -0400
Date: Tue, 18 Apr 2006 23:38:33 +0200
From: Kurt Garloff <garloff@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Gerrit Huizenga <gh@us.ibm.com>,
       James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418213833.GC5741@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	fireflier-devel@lists.sourceforge.net
References: <20060417225525.GA17463@infradead.org> <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com> <20060418115819.GB8591@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <20060418115819.GB8591@infradead.org>
X-Operating-System: Linux 2.6.16-14-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 18, 2006 at 12:58:19PM +0100, Christoph Hellwig wrote:
> It's doing access control on pathnames, which can't work in unix envirome=
nts.
> It's following the default permit behaviour which causes pain in anything
> security-related (compare [1]).

Pathnames are problematic, no doubt.
So AppArmor does currently do some less-than-nice things to get around
this.
On the other side, pathnames is what the admins see and use, so it is
the right abstraction for the sysadmin, if you want to make a higher
level of security available to people without the need to get them
a large amount of extra training.
So that gap needs to be bridged somehow.
Maybe there are better ways compared to what AA does currently, and
constructive suggestions are very welcome!

And no, just claiming that AA is useless or crap is not constructive
AFAICT. And saying that is should be better done as part of SElinux
is not either.

The goals are quite different. SElinux is a solution that wants to
implement policies that cover lots of things. It's accordingly powerful
and complex.

AppArmor is easy. Everyone with a little background in Un*x can
understand what it does and how it needs to be configured.
Eventually, most sysadmins of the world can configure it correctly
and thus make their systems more secure.
(The submission to LKML should happen RSN, the committment has
 been there since a long time!)

I don't want to judge, but I think the approaches and goals are=20
different enough to grant both (and evetually others) the right=20
to live.

Actually, I'm a bit worried about the discussion.
When I chose Linux, it was about the freedom of choice.
And we have a nice abstraction (LSM) that allows this freedom. At
a small price. It's not pleasant to see that some people want to move
away from that.

Best,
--=20
Kurt Garloff, Head Architect Linux R&D, Novell Inc.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFERVxZxmLh6hyYd04RAsa1AKCTjVzfEf6erjqZRRwEtcIW41O31gCghLn8
twBrEkgx+M0Ut2OzDmUi/jI=
=8/U+
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
