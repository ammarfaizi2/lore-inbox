Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129658AbQKOVtm>; Wed, 15 Nov 2000 16:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129932AbQKOVtd>; Wed, 15 Nov 2000 16:49:33 -0500
Received: from warande3094.warande.uu.nl ([131.211.123.94]:14165 "EHLO
	xar.sliepen.oi") by vger.kernel.org with ESMTP id <S129658AbQKOVt1>;
	Wed, 15 Nov 2000 16:49:27 -0500
Date: Wed, 15 Nov 2000 22:19:23 +0100
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: (iptables) ip_conntrack bug?
Message-ID: <20001115221922.L13682@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001115154603.D4089@psuedomode>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0jdOO2+ODOkP2/E4"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001115154603.D4089@psuedomode>; from safemode@voicenet.com on Wed, Nov 15, 2000 at 03:46:03PM -0500
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0jdOO2+ODOkP2/E4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2000 at 03:46:03PM -0500, safemode wrote:

> I was DDoS'd today while away and came home to find the firewall unable to
> do anything network related (although my connection to irc was still
> working oddly).  a quick dmesg showed the problem.
> ip_conntrack: maximum limit of 2048 entries exceeded
[...]

I have also seen this happen on a box which ran test9. Apparently because of
it's long uptime, because the logs should no signs of an attack.

I guess conntrack forgets to flush some entries? Or maybe there is no way it can
recover from a full conntrack table? Is it maybe necessary to make the maximum
size a configurable option? Or a userspace conntrack daemon like the arpd?

I also see a lot of messages like this (on all 2.4 test kernels):

NAT: 0 dropping untracked packet c00643f0 1 131.211.122.89 -> 224.0.0.2
NAT: 0 dropping untracked packet c05468e0 1 131.211.122.89 -> 224.0.0.2
NAT: 0 dropping untracked packet c0064760 1 131.211.122.31 -> 224.0.0.2

Turning of multicast on the respective network interface does not stop these
messages, but anyway they seem rather annoying to me :)

-------------------------------------------
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>
-------------------------------------------
See also: http://tinc.nl.linux.org/
          http://www.kernelbench.org/
-------------------------------------------

--0jdOO2+ODOkP2/E4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Ev3aAxLow12M2nsRAoMrAKCoj/y1WkRzDU0uxwgpLkRSknnWbgCcDFZf
yZiF1kdjywHAYP2AF3Xv2pk=
=LwKh
-----END PGP SIGNATURE-----

--0jdOO2+ODOkP2/E4--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
