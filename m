Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266177AbUFIWt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUFIWt1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266202AbUFIWtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:49:14 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:16821 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S266177AbUFIWsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:48:54 -0400
Message-ID: <40C793CE.6000609@g-house.de>
Date: Thu, 10 Jun 2004 00:48:46 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: NetDev Mailinglist <netdev@oss.sgi.com>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3: waiting for eth0 to become free
References: <1086722310.1682.1.camel@teapot.felipe-alfaro.com>	 <20040608124215.291a7072@dell_ss3.pdx.osdl.net>	 <1086725369.1806.1.camel@teapot.felipe-alfaro.com>	 <20040608140200.2ddaa6f4@dell_ss3.pdx.osdl.net> <1086794282.1706.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1086794282.1706.2.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
|>What is happening is that some subsystem is holding a reference to the
device (calling dev_hold())
|>but not cleaning up (calling dev_put).  It can be a hard to track
which of the many
|>things routing, etc are not being cleared properly.  Look for routes
that still
|>get stuck (ip route) and neighbor cache entries.  Most of these end up
being
|>protocol bugs.
|
|
| The two attached patches, one for net/ipv4/route.c, the other for net/
| ipv6/route.c fix all my problems when running "cardctl eject" while a
| program mantains an open network socket (ESTABLISHED).
|
| Both patches apply cleanly against 2.6.7-rc3 and 2.6.7-rc3-mm1.
| I'm not completely sure what has changed in 2.6.7-rc3 that is breaking
| cardctl for me, as it Just Worked(TM) fine in 2.6.7-rc2.

do you know, by any chance, if this error is dependent to eth0 only or
could help for my error message too:

unregister_netdevice: waiting for ppp0 to become free. Usage count = 1

happened just a few hours ago (2.6.7-rc3), i had to reboot the box
anyway, but pppd was not able to die (even with kill -9)

Christian.
- --
BOFH excuse #258:

That's easy to fix, but I can't be bothered.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAx5PN+A7rjkF8z0wRAuR+AJ41024qDMPVWYlVeofUZ6N50E3oRwCfeqhs
/GxxIqmDbClJXw/i2WNhJt4=
=lHgP
-----END PGP SIGNATURE-----
