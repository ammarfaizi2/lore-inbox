Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVASOMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVASOMe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVASOMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:12:34 -0500
Received: from relay.snowman.net ([66.92.160.56]:19465 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S261729AbVASOM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:12:26 -0500
Date: Wed, 19 Jan 2005 09:11:15 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
       George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119141115.GI10437@ns.snowman.net>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
	George Anzinger <george@mvista.com>,
	john stultz <johnstul@us.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Con Kolivas <kernel@kolivas.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050119000556.GB14749@atomide.com> <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com> <1106112525.4534.175.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1TpPISuMFJtSn3D"
Content-Disposition: inline
In-Reply-To: <1106112525.4534.175.camel@gaston>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 09:04:42 up 354 days,  9:00,  7 users,  load average: 0.10, 0.17, 0.13
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--S1TpPISuMFJtSn3D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> Hrm... reading more of the patch & Martin's previous work, I'm not sure
> I like the idea too much in the end... The main problem is that you are
> just "replaying" the ticks afterward, which I see as a problem for
> things like sched_clock() which returns the real current time, no ?
>=20
> I'll toy a bit with my own implementation directly using Martin's work
> and see what kind of improvement I really get on ppc laptops.

I don't know if this is the same thing, or the same issue, but I've
noticed on my Windows machines that the longer my laptop sleeps the
longer it takes for it to wake back up- my guess is that it's doing
exactly this (replaying ticks).  It *really* sucks though because it can
take quite a while for it to come back if it's been asleep for a while.

	Stephen

--S1TpPISuMFJtSn3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB7mqCrzgMPqB3kigRAvDJAJoCODq7uqyk+SFhAc64+mq8n6woEwCfZ06b
nKXq1FAiXk+QKlK0QqPNWJA=
=btXW
-----END PGP SIGNATURE-----

--S1TpPISuMFJtSn3D--
