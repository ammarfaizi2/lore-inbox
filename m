Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbUJ0Pgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbUJ0Pgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUJ0Pgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:36:36 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:46993 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262489AbUJ0PfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:35:17 -0400
Message-ID: <417FC02C.3090001@comcast.net>
Date: Wed, 27 Oct 2004 11:35:08 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Willy Tarreau <willy@w.ods.org>, Rik van Riel <riel@redhat.com>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com> <20041027051342.GK19761@alpha.home.local> <20041027052321.GT15367@holomorphy.com> <417FA711.90700@comcast.net> <20041027145743.GA16666@thunk.org>
In-Reply-To: <20041027145743.GA16666@thunk.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Theodore Ts'o wrote:
| On Wed, Oct 27, 2004 at 09:48:01AM -0400, John Richard Moser wrote:
|
|>I for one don't give a damn.  Bugs and how fast this development model
|>fix them aren't a concern to me; although I'd never slow down the bug
|>fixing process.  My concern is getting a real stable tree for various
|>maintainers to base on, so that various patches for drivers, security
|>enhancements, and other things aren't scattered across versions and
|>impossible to patch together even when they're noninvasive to eachother.
|>
|>Have you stopped to consider that the features that are critical to me
|>are also holding me back from upgrading to the newer kernels?
|>Ironically, these are security features, and the newer kernels have
|>newer security fixes aside from new schedulers and other toys I could
|>really enjoy having around.
|
|
| So instead of kvetching, why don't you
|
| (a) Create your own stable series by snapshotting some 2.6.x tree
| every six months, and then maintain a set of bug-fix only patches
| against that 2.6.x tree?  Then convince the security people to port to
| that particular 2.6.x-jrm tree?
|

- - Convince the security people
- -- PaX, GrSecurity (2.6.7)
- -- LIDS (2.6.8.1) (not my problem)
- -- RSBAC (The author works his ass off, 2.6.6-9)
- - Convince VM hacker projects
- -- linuxcompressed is dead anyway; but they'd have a hard time keeping
~    up; there's been VM changes a few times already ne?
- - Convince filesystem and driver projects.  No particular examples,
~  although I could see things happening that would affect them (another
~  reason why we need a fully upwards-compatible driver ABI)

| (b) Convince the security folks to try to get their patches into the
| mm- tree, for eventual inclusion into 2.6.
|

I've tried that.  They don't want to.  I don't blame them.

What I *am* aiming for is getting a few security enhancements included
in mainline for several Linux distributions, starting with Debian and
Ubuntu.  This will predictibly create a blockage at 2.6.7 (where
PaX/GRSec are, since those are a major part of the scheme); they won't
be able to upgrade past there without losing a major protection, and the
authors will likely continue to simply sit around and wait for 2.6 to
stop changing so damn much.

| (c) Some combination of the two.
|
| Either would probably be more likely to fulfill your needs than just
| whining about it.
|
| 						- Ted
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBf8AshDd4aOud5P8RAjwtAJ4je6e8ubxmnMJexVY0Db6JSNRPLwCeMvNY
HjEB1Ve+ZSdToiwPOsMJWnM=
=DJkR
-----END PGP SIGNATURE-----
