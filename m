Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVC1WR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVC1WR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 17:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVC1WR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 17:17:56 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:50627 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262083AbVC1WRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 17:17:48 -0500
Message-ID: <4248828B.20708@comcast.net>
Date: Mon, 28 Mar 2005 17:17:47 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brandon Hale <brandon@smarterits.com>
CC: Arjan van de Ven <arjan@infradead.org>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
References: <42484B13.4060408@comcast.net>	 <1112035059.6003.44.camel@laptopd505.fenrus.org>	 <4248520E.1070602@comcast.net>	 <1112036121.6003.46.camel@laptopd505.fenrus.org>	 <424857B0.4030302@comcast.net> <1112043246.10117.5.camel@localhost.localdomain>
In-Reply-To: <1112043246.10117.5.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Brandon Hale wrote:
>>>actually Linus was really against adding non-related things to this
>>>flag. And I think he is right...
>>>
> 
> 
> Makes sense to me.
> 
> 

[...]

> 
> IMO you have this backwards, John.  Rather than having the majority (ES,
> mainline NX stuff) respect your less popular branch, it would make sense
> to have PaX work as well as possible with PT_GNU_STACK, and politely
> request that any missing functionality be duplicated in ES. PT_GNU_STACK
> is the most widely available header, and we should leverage that
> ubiquity as much as possible.  Marking our binaries with PT_PAX_FLAGS
> and then begging everyone else to support our way of doing things will
> never work.
> 

You need to consider that in the end I'd need PT_GNU_STACK to do
everything PaX wants, and to make PF_X a tristate (On, Off, Neutral)
which mapped to PF_PAGEEXEC in PaX.  In other words, I'd have to
overhaul and most likely *break* everything else that relied on
PT_GNU_STACK, instead of passively adding logic for PT_PAX_FLAGS and
letting everyone else catch up at their leisure.

I'd rather not break anything and force everyone to upgrade *now*; but
instead add PT_PAX_FLAGS functionality for mainline/ES, let it lay there
for a year or so as people start moving over and accepting it, let the
kernel devs decide when it's time to depricate PT_GNU_STACK, and see it
naturally decay away once it's actually no longer needed.  The point is
to not break anything, yet to still make things easier for those
projects and distributions like Hardened Ubuntu.


> ---
> Brandon Hale

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSIKKhDd4aOud5P8RAkqEAJwNhFvfDc63qyPrBvMxs6naG1xuAQCfZKHn
upzqNI5/XzYVCmDKGM6q8ZY=
=YZkT
-----END PGP SIGNATURE-----
