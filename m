Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVAaXHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVAaXHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVAaXHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:07:34 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:20668 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261420AbVAaXHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:07:02 -0500
Date: Tue, 1 Feb 2005 00:06:57 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Steve Bergman <steve@rueb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance of iptables-restore on large rule sets
Message-ID: <20050131230657.GP6878@sunbeam.de.gnumonks.org>
References: <41FA8ADE.6080708@rueb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yUmmepPgoWmUqRhm"
Content-Disposition: inline
In-Reply-To: <41FA8ADE.6080708@rueb.com>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -2.4 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yUmmepPgoWmUqRhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 28, 2005 at 12:56:30PM -0600, Steve Bergman wrote:
> I have a large rule set (~53000 rules) that I sometimes load using=20
> iptables-restore.  (It takes almost an hour.

That's really slow.  I've seen multiple minutes, but an hour?  What kind
of system is this?  How does the ruleset look like?  Maybe some dns
resolvals are timing out?

> Googling around tells me that the loop detection code in the kernel is=20
> slow with large rule sets. =20

That's wrong.  What used to be slow is libiptc.  iptables-1.2.11 should
actually already be significantly faster than all prior versions.

Please try the current pre-1.3.0 snapshots from
ftp://ftp.netfilter.org/pub/iptables/snapshot

Please report back if they solve your performance issue.

> Steve Bergman
--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--yUmmepPgoWmUqRhm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB/roRXaXGVTD0i/8RAkNEAKCiT+dUOXGxEYS6SYDT4nrsK3pCQQCcDaKm
sJFP3/teLxlbactauvcqnFk=
=GuuK
-----END PGP SIGNATURE-----

--yUmmepPgoWmUqRhm--
