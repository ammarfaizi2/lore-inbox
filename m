Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbTEJH0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 03:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbTEJH0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 03:26:12 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:11168 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263669AbTEJH0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 03:26:11 -0400
Date: Sat, 10 May 2003 10:38:42 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  new syscall to allow notification when arbitrary pids die
Message-ID: <20030510073842.GA31003@actcom.co.il>
References: <3EBC9C62.5010507@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <3EBC9C62.5010507@nortelnetworks.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2003 at 02:29:54AM -0400, Chris Friesen wrote:

> I see two immediate uses for this.  One would be to enable a "watcher"=20
> process which can do useful things on the death of processes which=20
> registered with it (logging, respawning, notifying other processes,
> etc). =20

Do it from user space, kill(pid, 0), check for ESRCH. I might see the
benefit of a new system call if it was synchronous (wait() semantics),
but since signal delivery is asynch anyway....=20

> The second would be to enable mutual=20
> suicide pacts between processes. (I'm not sure when I would use this, but=
=20
> it sounds kind of fun.)

Same thing, kill(pid, 0).

> Anyone have any opinions on this? =20

There's already a well established way to do what you want (get
non-immediate notification of process death). What benefit would your
approach give?=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+vKyCKRs727/VN8sRAoPYAKCF+9tHhx7cIPWjOdSBEF1H51dZZACeKZ4Z
m2zkdpjkRK4QOg8BSJ7dc44=
=3MNT
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
