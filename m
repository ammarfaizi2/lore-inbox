Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUKIMdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUKIMdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbUKIMdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:33:33 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:14564 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261528AbUKIMdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:33:25 -0500
Message-ID: <4190B910.7000407@g-house.de>
Date: Tue, 09 Nov 2004 13:33:20 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Pekka Enberg <penberg@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de>	 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>	 <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de>	 <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>	 <418F6E33.8080808@g-house.de>	 <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>	 <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>	 <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com>
In-Reply-To: <84144f02041108234050d0f56d@mail.gmail.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

this damn thread is far too long already...


Pekka Enberg schrieb:
> CONFIG_PREEMPT is one obvious candidate (you have that enabled in the
> original config and disabled in the non-oopsing one).

i've disabled *only* CONFIG_PREEMPT in another .config but it still oopses:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-debug_oops-2.6.10-rc1_no-preempt.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.10-rc1_no-preempt.txt

2.6.9 with preempt enabled does not oops:
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.9_preempt.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-no-oops_2.6.9_preempt.txt

i was a fool to test further -bk snapshots but it was kinda late yesterday
 and i was confused:

patch-2.6.9.bz2          -> 19-Oct-2004
patch-2.6.10-rc1.bz2     -> 23-Oct-2004 00:12
patch-2.6.10-rc1-bk1.bz2 -> 23-Oct-2004 13:34

2.6.9 is not oopsing *here*, plain 2.6.10-rc1 is oopsing. so i can *not*
use -bk snapshots any more and i will go on with BK (undo the ChangeSets
Linus told me about) and use different .configs now. sorry for the
confusion and especially sorry to my bk mentor: we seem to be so close to
the right ChangeSet and then i started to use *snapshots* again.

Thanks,
Christian
- --
BOFH excuse #76:

Unoptimized hard drive
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkLkQ+A7rjkF8z0wRAhqLAJ9bZm+B5LKR+sY7V+yi/fSrhJuGrwCfcumS
GwsGsjKson9vwRMCDtT9/Zk=
=ailz
-----END PGP SIGNATURE-----
