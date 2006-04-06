Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWDFDZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWDFDZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWDFDZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:25:11 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:13740 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751349AbWDFDZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:25:10 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: Issues with uli526x networking module
Date: Thu, 6 Apr 2006 13:24:20 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <200601260900.57951.prakash@punnoor.de> <200603290747.38402.ncunningham@cyclades.com> <200604041615.10749.prakash@punnoor.de>
In-Reply-To: <200604041615.10749.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1662805.vJAVub7DLN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604061324.24499.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1662805.vJAVub7DLN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 05 April 2006 00:15, Prakash Punnoor wrote:
> Am Dienstag M=C3=A4rz 28 2006 23:47 schrieb Nigel Cunningham:
> > Hi.
> >
> > On Wednesday 29 March 2006 03:30, Prakash Punnoor wrote:
> > > Hi, I am just wondering whether you found out what the issue is with
> > > the link problem. If you have some patch ready (even if it is hackish)
> > > I would be happy to use it.
> > >
> > > Anyways, I know you are busy with swsusp2. ;-)
> > >
> > > Cheers,
> >
> > Yes, I do have a patch. It is hackish at the moment because as you've
> > rightly guessed, I haven't gotten around to finishing it. It also doesn=
't
> > work perfectly - I sometimes need to rmmod and insmod after booting a n=
ew
> > kernel to get the link to come up. But, apart from that, it works fine.
>
> Thx for sharing it. Unfortunately it doesn't help me. (I am not using
> suspend or anything on that machine as it is supposed to be running 24/7.)
> After pulling out the LAN cable and putting it back in. network is dead.
> The driver (even unpatched) sees the cable is back in, but obviously
> wrongly
> reinitializes(?) the nic: Ie, kernel says after pluggin cable back in:
>
> uli526x: eth0 NIC Link is Up 100 Mbps Full duplex
>
> but network is dead.
>
> I have to do:
>
> ifconfig eth0 down
> modprobe -r uli526x
> modprobe uli526x
> ifconfig eth0 up
> dhclient
>
> And then it works again.

Yes, this is what I was describing too. I need to learn more about how the=
=20
link control works.

Regards,

Nigel

--nextPart1662805.vJAVub7DLN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBENInoN0y+n1M3mo0RAg3QAKCSJcvEq4mGPpzLxg5d/icwvfULvQCgjUHt
o5TjZqkA8cTVJv081uKeuUs=
=8GY0
-----END PGP SIGNATURE-----

--nextPart1662805.vJAVub7DLN--
