Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUGOIA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUGOIA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 04:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUGOIA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 04:00:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266137AbUGOIAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 04:00:54 -0400
Date: Thu, 15 Jul 2004 10:00:17 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: christophe.varoqui@free.fr
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Q] don't allow tmpfs to page out
Message-ID: <20040715080017.GB20889@devserv.devel.redhat.com>
References: <1089878317.40f6392d7e365@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <1089878317.40f6392d7e365@imp5-q.free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Jul 15, 2004 at 09:58:37AM +0200, christophe.varoqui@free.fr wrote:
> > 
> > just do 
> > mount -t ramfs none /mnt/point
> > 
> Would that be a suitable solution to store callout binaries for daemons like
> multipathd that need to work in case of system-disk outage (/bin & swap on SAN
> for example) ?

somewhat, as long as ALL requirements are there, including all libraries ;)

> If so, is it possible and/or correct for the daemon to do a private ramfs mount
> for this purpose ?

sure; namespaces can do a LOT
> 
> And while I'm at throwing all the questions I have on my mind :
> * how can I disable on-demand loading for the daemon ?
> * does mlockall() provides all the necessary garanties ?

mlockall does not guarantee that syscalls you do don't cause memory
allocations, nor does the ramfs approach.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA9jmQxULwo51rQBIRAkaKAKCcFeHDs+07XPTF05K/7Jnr6eeUKACdFtZM
RsFJNlCBRTo2iCPviMT3HhE=
=eJZV
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
