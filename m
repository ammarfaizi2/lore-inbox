Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbUJ1C0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUJ1C0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 22:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbUJ1C0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 22:26:46 -0400
Received: from eth2613.sa.adsl.internode.on.net ([150.101.239.52]:33925 "EHLO
	foghorn2.internal") by vger.kernel.org with ESMTP id S262712AbUJ1CZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 22:25:38 -0400
Date: Thu, 28 Oct 2004 11:55:30 +0930
From: John Pearson <jpearson@sa.pracom.com.au>
To: linux-kernel@vger.kernel.org
Cc: Dominik Karall <dominik.karall@gmx.net>
Subject: Re: Neighbour table overflow.
Message-ID: <20041028022530.GA2936@sa.pracom.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5.8
X-Spam-Report: Spam detection software, running on the system "foghorn2.internal", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  You may also be the 'victim' of a poorly configured
	router. Out-of-the box, Cisco routers come with proxy ARP enabled; they
	will reply to ARP requests for any IP they can route, that isn't routed
	via the interface they receive an ARP request on. This makes them more
	'plug-and-playful' for equipment that talks IP, but doesn't understand
	routing (assuming any still exists). [...] 
	Content analysis details:   (-5.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may also be the 'victim' of a poorly configured router.

Out-of-the box, Cisco routers come with proxy ARP enabled;
they will reply to ARP requests for any IP they can route,
that isn't routed via the interface they receive an ARP 
request on.  This makes them more 'plug-and-playful' for 
equipment that talks IP, but doesn't understand routing
(assuming any still exists).

Check the output of
  arp -an
and see if there isn't a single MAC accounting for the lion's
share of your ARP cache.  If there is, seek and destroy^H^H^H^H^Hfang


On Wed, Oct 27, 2004 at 02:30:32AM +0200, Dominik Karall wrote
> --nextPart2038980.5ceDjSAWoH
> Content-Type: text/plain;
>   charset=3D"iso-8859-1"
> Content-Transfer-Encoding: quoted-printable
> Content-Disposition: inline
> 
> On Wednesday 27 October 2004 01:06, David S. Miller wrote:
> > On Wed, 27 Oct 2004 00:11:26 +0200
> >
> > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > On Tuesday 26 October 2004 23:52, Ernst Herzberg wrote:
> > > > On Tuesday 26 October 2004 19:39, Dominik Karall wrote:
> > > > > can anybody explain why i get thousands of "Neighbour table
> > > > > overflow." messages? i didn't get such ones with older kernels
> > > > > (~2.6.6).
> > > >
> > > > Do you set a default gateway?
> > >
> > > yes, default gateway is set to our server.
> >
> > Do you use a large subnet mask?  For example /16 or /8 or
> > something like that?
> >
> > If so, you will need to bump up the neighbour table garbage
> > collection thresholds under /proc/sys/net/ipv4/neight/default/
> > Specifically gc_thresh1, gc_thresh2, and gc_thresh3
> >
> > You probably have a huge number of machines on your subnet.
> 
> the subnet mask is set to 255.255.0.0, and there are machines from 172.16=
> .0=3D
> =3D2E1=3D20
> to 172.16.1.254. but not all ips are reserved. there are "only" about 100=
> =3D20
> machines in the network.
> i will try to change the values of gc_thresh*, maybe it helps. thx!
> 
> dominik
> 
> --nextPart2038980.5ceDjSAWoH
> Content-Type: application/pgp-signature
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> 
> iQCVAwUAQX7sKgvcoSHvsHMnAQJXqgP/eFTl/SzsI83Q/WgZmlaJ9xPCXsSxFbQm
> 2UmR4cHDZti6mOzKeAOI/O91S+xTkFvdYmVgm+k+TAaUpy6OHa1Lx84y9H7uMa7P
> 7afLf9+qQ00pi+uUp9srhihpiwt1yEYRWuvc9NaZhYfl9EJdeQmGNy6M7tlSwV07
> mxTCNjVqBBU=3D
> =3DZ8MD
> -----END PGP SIGNATURE-----
> 
> --nextPart2038980.5ceDjSAWoH--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
> n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> --__--__--

-- 
Voice: +61 8 8202 9040
Email: jpearson@sa.pracom.com.au

Pracom Ltd
288 Glen Osmond Road
Fullarton, South Australia 5063

Ph: + 61 8 82029000
Fax: +61 8 82029001

CAUTION: This email and any attachments may contain information that is
confidential and subject to copyright. If you are not the
intended recipient, you must not read, use, disseminate, distribute or
copy this email or any attachments. If you have received this
email in error, please notify the sender immediately by reply email and
erase this email and any attachments.

DISCLAIMER: Pracom uses virus-scanning technology but accepts no
responsibility for loss or damage arising from the use of the
information transmitted by this email including damage from virus.

