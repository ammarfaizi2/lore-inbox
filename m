Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUBTOLH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUBTOLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:11:06 -0500
Received: from D71a0.d.pppool.de ([80.184.113.160]:61890 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261207AbUBTOKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:10:42 -0500
In-Reply-To: <20040125230753.A20686@electric-eye.fr.zoreil.com>
References: <1075059124.13750.38.camel@sonja> <20040125230753.A20686@electric-eye.fr.zoreil.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-10-187666238"
Message-Id: <F8A4CD84-639D-11D8-8BA0-000A9597297C@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: [PATCH] Re: rtl8169 problem and 2.4.23
Date: Fri, 20 Feb 2004 13:11:53 +0100
To: Francois Romieu <romieu@fr.zoreil.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-10-187666238
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Jan 25, 2004, at 11:07 pm, Francois Romieu wrote:

> Try the patch above. If it compiles, it should fix the stats and you 
> get a
> bugfix as an extra.

Sorry for the delay. I've not had the chance to recompile the kernel
for my fileserver and restart it, yet. But in the meantime I've received
another card with RTL8169S and tried it in a different machine.

The current driver in 2.4.24 and 2.6.3 will lock up the box in almost
no time when under load (not a real kernel lockup but a soft one because
the machine is running over NFS and the driver seems to lose packets
and then rejects to transfer more). Your patch fixes this problem and 
the
counter issue for both 2.4.24 and 2.6.3, so it probably should go in 
ASAP.

However there's another thing bugging me: abysmal performance. In both
a switched and a direct environment the best I could get using netio
was 10MB/s send and 21MB/s receive, using NFS I get just under 10MB/s,
this is slower than with a 8139 el cheapo 100Mbit card.

The netio results are illogical anyway because the other side is the
fileserver, which has the same card, so if one end receives 21MB/s the
other end has to send equally as fast, no? :) The CPU utilization was
almost zero on server and client (both Athlon XP).

Servus,
       Daniel

--Apple-Mail-10-187666238
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQDX5ijBkNMiD99JrAQJVGAf/eRBGDLzhkGOwtxJj/s++N9yQqZjbiQhU
A/D7aIYg/rNuV6/egaxjDsImhluSq8LZEjVr7YAKq9tYBNsmY+ENdazxexCzdDdF
PxoQ7T4ZhXNa0b3mPhQmFlCGXcUeQcomoT3Ux8+N8jZ58UaUOWzp7BJxXf/40aHW
hQuG4z2zK3khM3Aakr6MJZY7iJzwXDnalm8UzKZ2A5qXReXKizu/rCJx91PX0AYK
V+jb4I34cTfSa4Og1s6yFosO7ea2P/yVPMx2d0JV79ypwMsGATTJD9vfV7Iz2OJM
+P5UbwXx5mkyg42HrfZoU8ZMN3ZHrR+9T1uVJQ/BANQyWcdse+DvPw==
=NlSC
-----END PGP SIGNATURE-----

--Apple-Mail-10-187666238--

