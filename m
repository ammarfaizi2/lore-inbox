Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTLHTk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTLHTk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:40:26 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23170 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261299AbTLHTkU (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:40:20 -0500
Message-Id: <200312081940.hB8Je8fD023223@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer 
In-Reply-To: Your message of "Mon, 08 Dec 2003 10:53:24 PST."
             <Pine.LNX.4.58.0312081046200.13236@home.osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20031207110122.GB13844@zombie.inka.de> <Pine.LNX.4.58.0312070812080.2057@home.osdl.org> <br28f2$fen$1@gatekeeper.tmr.com> <200312081753.hB8HrQfD019477@turing-police.cc.vt.edu>
            <Pine.LNX.4.58.0312081046200.13236@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_143348448P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Dec 2003 14:40:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_143348448P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Dec 2003 10:53:24 PST, Linus Torvalds said:

> Valdis: for /dev/hdxx, you can rename it with such esoteric programs as
> 'mv', 'ln', 'perl', 'cp', 'mknod', 'emacs', and a few hundred others. What
> is your beef with it?

The difference is that with nameif, I can feed it the MAC address and use
that as a "find this interface" key.  And given that at the moment, my lap
top has *4* ethernet devices (an onboard one, one in the docking station,
a wireless card, and one that happens to be be on a Xircom modem card),
it's really handy to be able to be able to nail down the names.

Yes, there's 3 zillion ways to rename the device, once I figure out what it's
name *is*.   Currently, my machine has a nice symlink set up:

% ls -l /dev/cdroms/
total 0
   0 lr-xr-xr-x    1 root     root           33 Dec 31  1969 cdrom0 -> ../ide/host0/bus0/target1/lun0/cd

which devfs was nice enough to do.  My beef is that if I had 2 cdroms, then
there's no guarantee of stability for cdrom0/cdrom1, and unlike the nameif
example, there's no really good way to deal with it (especially when you start
dealing with hotplug devices).

Or as another poster commented, it's easy to use /dev/cdrom-blue-faceplate once
you make it a symlink to the right place.  It's getting that symlink into place
that's the fun part. I admit I haven't looked at the udev stuff - is it able to
look closely enough at devices to do things like "I want the Mitsubishi CDrom
to be cdrom0 and the FireWire/USB/whatever to be cdrom1 if it's my Fujitsu,
but call it cdrom2 otherwise"? If so, then I don't have a beef with it... ;)

The stuff that supports LABEL= on a partition is a *partial* solution to
decouple the name of the device as the system found it from a logical name, but
as many have noted, it has its own issues.


--==_Exmh_143348448P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/1NOYcC3lWbTT17ARAlWsAKD1Q9DgoRL7fE4MpQPPSVo4blQOAQCgme4N
4waRrCJw5nzBsXoAZ6R6xoU=
=0AYW
-----END PGP SIGNATURE-----

--==_Exmh_143348448P--
