Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbUJZRGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUJZRGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUJZRGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:06:51 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14752 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261344AbUJZRGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:06:46 -0400
Message-ID: <417E8422.3020009@comcast.net>
Date: Tue, 26 Oct 2004 13:06:42 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROPOSAL:  New NEW development model
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In lieu of the recent unpleasantness[1] about the new development model,
and of some unexpected nastiness[2] as well, I propose that a very
slight modification be made to the current development model.  This
would merge the previous and new development models (as far as my
understanding is on them) and create a solution for all.

[1] http://lkml.org/lkml/2004/10/22/497
[2] http://lkml.org/lkml/2004/10/26/155

Previously, there were "Stable" and "Development" branches.  The
"Stable" branches, such as 2.2 and 2.4, would stagnate, and rarely have
backported features.  The "Development" branches such as 2.3 and 2.5
would be hammered and mixed with patches, then cleaned up until they
were fairly stable.  Then they'd be hammered with more patches, then
cleaned up, then frozen, cleaned up until "stable" and then released.

Under the new development model, the "Stable" branch appears to be more
"volatile."  New patches and heavy VM and scheduling changes are freely
added, as long as they're stable.  It's not quite "Unstable," but it's
closer to "Development" than "Stable."

I propose that a new development model involving "Stable" and "Volatile"
branches be made.  This would allow development to progress, but still
provide a stable kernel for patch maintainers to work with.

The "Stable" kernel will be the even releases, 2.6 2.8 3.0 and so on.
These should only have security fixes and bug fixes.  No backporting
should be done.  Drivers are a grey area; although this development
model aims to evade the backporting of drivers.

The "Volatile" kernel will be the odd releases, 2.7 2.9 3.1 and so on.
These should follow the current development model of 2.6; new
schedulers, new VM, new drivers, new features all around should be
thrown at the "Volatile" kernel *IF* *THEY* *ARE* *MEANINGFULLY*
*STABLE*.  In this way, the "Volatile" kernel will be suitable for
general use, and will remain fairly "stable."

A stable release cycle should be set up.  Approximately once every six
months, we'll say for example January 31 and July 31 to avoid the whole
Christmas/New Years holiday glob interfering around Jan., the "Volatile"
branch should be frozen into "Stable."  At this point, the new "Stable"
will immediately be equivalent to the latest state of the previous
"Volatile."  Also, because "Volatile" does not break to wait for
"Stable" to "Sableize," it would immediately fork to the next "Volatile"
series.

In effect, there will be no freezes ever.  Once every 6 months, Volatile
will fork into Stable and the next Volatile simultaneously, without a
pause.  Because Volatile will be continually kept up as a functional,
usable kernel as 2.6 is now, there will be no need for a grace period
for bug fixes.

Comments?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfoQihDd4aOud5P8RAvMWAJwKqPxmwD6lMFVchDlhf2RrujhsIwCgkTrZ
a6uQLECNDF68nfC4mMCTX8g=
=HLYr
-----END PGP SIGNATURE-----
