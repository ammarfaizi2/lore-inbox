Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUJZTZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUJZTZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUJZTZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:25:44 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:61832 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261519AbUJZTY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:24:59 -0400
Message-ID: <417EA486.7070105@comcast.net>
Date: Tue, 26 Oct 2004 15:24:54 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Boyer <jdub@us.ibm.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL:  New NEW development model
References: <417E8422.3020009@comcast.net>	 <20041026174730.GL17038@holomorphy.com>  <417E966D.8090208@comcast.net> <1098817715.9350.2.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1098817715.9350.2.camel@weaponx.rchland.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Josh Boyer wrote:
| On Tue, 2004-10-26 at 13:24, John Richard Moser wrote:
|
|>| This is not useful to distinguish your "suggestion" from the status quo.
|>|
|>
|>Help me out here, what's the status quo?
|
|
| Pretty much exactly what you described already.  Instead of "Volatile"
| being name 2.7, it's essentially 2.6.N-rcX.  (Or whatever Linus has
| chosen as the new naming convention for as yet to be released stuff.)
|
| At least that's how your proposal reads to me.
|

That's the point.  I'd like the current model to split off the
development into a separated branch, and do periodic stable releases.  I
think this would allow a much cleaner operation than simply consistantly
enhancing the Stable branch.  It's not that 2.6 is
unstable/hackish/crashy/etc, it's that development away from mainline is
more difficult which worries me.


I'd like to make a quick note here that "bugfixes and security updates"
should be trimmed to just "bugfixes," since usually "security updates"
just means "bugfixes for security holes."  I'd like to avoid confusion
with security updates such as new LSM hooks and SELinux extensions etc etc.

It would still require Linus to make periodic intermediate releases on
the Stable branch for bug fixes; and someone would have to backport such
bugfixes from Volatile, where they'd probably be found.  So there's some
upkeep, but minimal.

The point of restricting this upkeep as much as possible-- to the point
of allowing only bugfixes-- would be to keep pressure off the Stable
line maintainers.  If release periods are approximately every 6 months,
new drivers and features such as schedulers will be available every 6
months.  No need to waste time and effort backporting what's soon to be
stable anyway.

As for heavier work such as full scheduler rewrites, they could chase
Stable and go into Volatile; although it may be a good idea for such
things to make themselves known so that Volatile (and subsiquent
Stables) can avoid overlapping work, making it difficult for the side
project to keep up.

Still, a month or two to adapt to a new task scheduler out of 6 months
leaves 4-5 months per stable release if the Volatile branch decides to
hack up the scheduler.  This is still a better scenario then "VM and
scheduler infrastructures may change on any given release."



So OK, that's what's good here; so what's wrong with it?  We've already
established that there will be a minimal level of added work for a
maintainer to keep the Stable up.  Are there any other drawbacks?  If
not, any objections to trying to sell this one to Linus and Andrew?  :)

| josh
|
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

iD8DBQFBfqSEhDd4aOud5P8RAt6QAKCBdRm+e5yHhL7xmTZuAbIYIhzXXwCaAhxF
DsAfQhC3R4gy87LaB5DMXnM=
=7KX/
-----END PGP SIGNATURE-----
