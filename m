Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423450AbWBBKdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423450AbWBBKdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423449AbWBBKdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:33:06 -0500
Received: from 60-240-149-171.tpgi.com.au ([60.240.149.171]:8942 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1423450AbWBBKdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:33:05 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 20:29:28 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602021922.11100.nigel@suspend2.net> <20060202101626.GD1981@elf.ucw.cz>
In-Reply-To: <20060202101626.GD1981@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2909728.OFYGRmjUa6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022029.32524.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2909728.OFYGRmjUa6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 20:16, Pavel Machek wrote:
> > I'm more concerned about the security implications. I'll freely admit
> > that I haven't spent any real time looking at your code, but I'm
> > concerned that the additional functionality made available could be used
> > by viruses and the like. I'm sure you'd have to be root to do anything,
> > but how could the interfaces be misused?
>
> In vanilla kernel userland suspend has no security implications: root
> can just do what he wants in /dev/mem, anyway.

Ok.

> In fedora kernel, userland suspend can be [miss]used to snapshot an
> image, modify it, and write it back. Fortunately, this is going to
> take *long* time so people will notice. [Interface changed on DaveJ's
> request, now we have separate device, we no longer mess with
> /dev/mem]. And similar problem exists in suspend2 -- malicious
> graphical progress bar could probably modify memory image on disk.

How? It's just an ordinary process with no special permissions or access to=
=20
memory. The communication between the userspace process and the kernel is i=
n=20
the form of a netlink socket, with the only messages sent back and forth=20
being what should be displayed or what actions the user requested. Everythi=
ng=20
related to preparing the image and performing the I/O is done in the kernel=
=2E=20
There's no way I can see that a malicious userspace program could modify=20
anything but its own memory.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2909728.OFYGRmjUa6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4d8MN0y+n1M3mo0RAl2QAJ9YcdSi0tHYh6Wy5yys6j88J/MBnQCfXo8H
UzyL0KQSELUD0sGXIkDfFbI=
=QOiN
-----END PGP SIGNATURE-----

--nextPart2909728.OFYGRmjUa6--
