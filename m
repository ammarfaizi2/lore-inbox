Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbUJ0Niz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbUJ0Niz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUJ0Niz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:38:55 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:23959 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262404AbUJ0Ni2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:38:28 -0400
Message-ID: <417FA4CB.1060901@comcast.net>
Date: Wed, 27 Oct 2004 09:38:19 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Rik van Riel <riel@redhat.com>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com> <20041027051342.GK19761@alpha.home.local>
In-Reply-To: <20041027051342.GK19761@alpha.home.local>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Willy Tarreau wrote:
| On Wed, Oct 27, 2004 at 12:29:10AM -0400, Rik van Riel wrote:
|
|>On Wed, 27 Oct 2004, Marcos D. Marado Torres wrote:
|>
|>
|>>When it happened in 2.4 2.5 was created. Isn't all this just the
|>>indication that we need a 2.6 development like 2.4 is, and we need 2.7
|>>to be created?
|>
|>While a 2.7 series might provide developers with an "outlet"
|>for their creativity, it does not give users the availability
|>of the features they need.
|
|
| Rik, "new features" are what causes the kernel to be in permanent
development
| mode. It happened to all of us that a new feature broke compatability
with a
| patch or even caused a side effect. Users don't "need" new features, they
| *want* them.

Strong point.

[...]

|
| If you think that new features is something absolutely necessary, then we
| could have a permanent 4-digit kernel version.

Undue work.  The current high-speed development model could be reused as
2.7's development model.  Since it's good enough to use on the stable
tree, it can be said that 2.7 will always be stable, and so it can be
released often.  Also, distributions/users can cling to 2.7 and use it
freely without worrying that it's an explosive dev kernel that will eat
their hard drives.

[...]

|
|
|>Most features are developed because a user needs them now,
|>so having the users wait until 2.8 is not acceptable.
|
|
| yes it would be acceptable if 2.8 was expected only half a year from now.

Half year release cycle, as I said in my proposal[1], using a volatile
but usable tree (as 2.6 is now) instead of a flat out unstable tree (as
2.5 was) for the odd majors.  I think we can endure another 3 months of
the kernel acting up like this, and then freeze it January 31 and branch
it to 2.7 with the same behavior as it has now WRT patching and new
features; of course, that's not my call.

[1] http://lkml.org/lkml/2004/10/26/171

What's important here is to keep the current development model in
spirit.  It's obviously working if you can call a very volatile tree
"stable," so we shouldn't revert completely to stone-age methods; but
having a defined release cycle is easy if the development trees are
handled as 2.6 is now.

|
|
|>Making
|>the distributions backport the needed features into 2.6 leads
|>to lots of duplicate effort and some code fragmentation.
|
|
| I agree, and it also causes incompatibility between systems. I recently
| sadly discovered that RHEL 3.0 was not "Linux" anymore, but "RHEL". With
| all the 2.6 backports into 2.4, you cannot make it boot on a true 2.4
| anymore. Very sad indeed.
|

Dude, lots of crap won't boot 2.4.  Try booting Reiser4 on 2.4 (there's
no reiser4 for 2.4).

| Cheers,
| Willy
|


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBf6TKhDd4aOud5P8RAhVCAJwMugUdGgYnezh3/ONjNQWIppuetwCfUppX
pQfKCRw3rwFXOeJO2NtFdmg=
=VgEV
-----END PGP SIGNATURE-----
