Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTFBFxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 01:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTFBFxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 01:53:16 -0400
Received: from h80ad26bd.async.vt.edu ([128.173.38.189]:4736 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261919AbTFBFxP (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 01:53:15 -0400
Message-Id: <200306020606.h5266A4v002522@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: About 2.5.70-mm3 
In-Reply-To: Your message of "Sat, 31 May 2003 23:21:22 +0300."
             <200305312321.22847.kde@myrealbox.com> 
From: Valdis.Kletnieks@vt.edu
References: <200305311507.53284.kde@myrealbox.com> <20030531104443.63cb1445.akpm@digeo.com>
            <200305312321.22847.kde@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1712630272P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Jun 2003 02:06:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1712630272P
Content-Type: text/plain; charset=us-ascii

On Sat, 31 May 2003 23:21:22 +0300, "ismail (cartman) donmez" said:
> On Saturday 31 May 2003 20:44, you wrote:
> > There's a little hack in there which speeds up the loading of executables:
> > when someone does a mmap of a file with executable permissions the kernel
> > will slurp it all into pagecache during the mmap.  That tends to speed up
> > program loading quite a lot, because the normal demand-loading produces
> > quite poor I/O patterns.
> Cool

Yes, *majorly* cool.  Between that tweak and the anticipatory scheduler,
it makes this laptop even more responsive than stock 2.5.70 was, and less
prone to hiccups - without -mm3, it was pretty easy to make xmms pause/skip
by suddenly hitting the disk with I/O.  I've been trying to make it skip
for an hour, even doing things like launching an X application while running
an MH 'scan' command on a 7,000 item folder (which involves an open, read,
close for 7,000 separate files), and that doesn't phase it at all..

> > I had a vague feeling that this code wasn't working actually, and
> > reimplemented it for -mm4.
> You do not really feel it in X but on system startup its *quite* impressive.

It's noticeable on launching X apps on my laptop, and at boot time, I was
wondering if my init scripts were scrogged - [OK] after [OK] faster than
I'd seen before.

Amazing work, thanks Andrew (and all the contributors...)

--==_Exmh_-1712630272P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+2ulQcC3lWbTT17ARAiDMAJ4tfjnsJ1/VL+dIMJ5LVPEeO7hd+gCglUuv
dvdLRpPpUtpGShe7af2LTNo=
=daPH
-----END PGP SIGNATURE-----

--==_Exmh_-1712630272P--
