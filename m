Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbUKUXGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbUKUXGD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUKUXGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:06:03 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:3759 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261829AbUKUXFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:05:55 -0500
Message-ID: <41A11F50.6060501@g-house.de>
Date: Mon, 22 Nov 2004 00:05:52 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: how to find out it's a memory leak?
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi list,

during the last weeks i've encounterd some OOM situation here on my little
server machine. that happened with some 2.6.9 and 2.6.10 kernels but i
never found out what the reason was. the machine was running for 2 or 3
weeks and constantly taking up more and more swap until the OOM killer did
his job and killed some task. i decided to reboot then, once i *had* to
reboot because the machine has locked up.
so i suspect a "memory leak" somewhere. knowing nothing about VM and
knowing the term "memory leak" only from hearsay, i just want to know

1) does a memory leak always occur in kernel space? or could some
   userspace application take up more and more swapspace too?
2) where can i look for the process to blame?

i've already thought about it and i really think a userspace app can also
be the bad one here, but "top" and "ps" won't tell me who's to blame.
perhaps somewhere under /proc, but i don't know where. can someone tell me
where to look for?

currently i'm running 2.6.10-rc1-bk19 and 436MB swapspace is already used.
that's not "normal" for this machine and i can from daily "free -m"
outputs that more and more swapspace is used - but i don't know by what!

thanks,
Christian.
- --
BOFH excuse #227:

Fatal error right in front of screen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBoR9Q+A7rjkF8z0wRAiJ6AJ9B1xGegsOUaZ5N0ux2sG6CABAwKQCeO4AF
3PaLcQJM48qOksTFBIKch/k=
=zC0i
-----END PGP SIGNATURE-----
