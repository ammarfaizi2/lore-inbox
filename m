Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUKHXti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUKHXti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUKHXth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:49:37 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:35288 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261307AbUKHXtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:49:12 -0500
Message-ID: <419005F2.8080800@g-house.de>
Date: Tue, 09 Nov 2004 00:49:06 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org> <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de> <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de> <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org> <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de>
In-Reply-To: <418FDE1F.7060804@g-house.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>Now, that's fine - the USB merge is likely to be ok, so try doing
>>>
>>>	bk undo -a1.2462

i did so, 1.2463 went away, building as usual - but the oops resists :(

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-debug_oops-a1.2462.txt

> 
> for now i appreciate your work here but i have to postpone the the "bk
> revtool" stuff because i have no X _and_ bk here. (but i'm a good student
> and will do my homework)

...in progress...



>>>
>>>	bk set -n -d -r1.2462 -r1.2463 | bk -R prs -h -d'<:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n' -
>>>
>>>which is black magic that does a set operation and shows all the changes 
>>>in between the sets of "bk at 1.2462" and "bk at 1.2463".

hm, i guess this has to wait now.

>>>Looking at the list (appended), I don't see anything obvious, but hey, if 
>>>it was obvious it wouldn't have been merged in the first place. 

yes, i'll look for changes regarding PCI. i've started to compile the -bk
snapshots too. there i can do less wrong things. when i have the "bad" -bk
snapshot i'll use "bk" itself again to find the detailed change leading to
the oops.

i hope to get another machine with a another es1371 tomorrow and see if
the error is reproduceable.

thanks,
Christian.

PS: i've taken linux-sound and alsa-devel from CC.
- --
BOFH excuse #74:

You're out of memory
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkAXx+A7rjkF8z0wRAttsAJ9sOI7FVw+Lx8rBYHusHILQvIkeJACfZWDX
zMY4MtVYCCxU3y0Tb/muG5Y=
=CBO/
-----END PGP SIGNATURE-----
