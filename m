Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264398AbUFJLHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUFJLHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 07:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUFJLHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 07:07:04 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:1987 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264398AbUFJLHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 07:07:00 -0400
Message-ID: <40C840C8.8000605@g-house.de>
Date: Thu, 10 Jun 2004 13:06:48 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: NetDev Mailinglist <netdev@oss.sgi.com>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3: waiting for eth0 to become free
References: <1086722310.1682.1.camel@teapot.felipe-alfaro.com>	 <20040608124215.291a7072@dell_ss3.pdx.osdl.net>	 <1086725369.1806.1.camel@teapot.felipe-alfaro.com>	 <20040608140200.2ddaa6f4@dell_ss3.pdx.osdl.net>	 <1086794282.1706.2.camel@teapot.felipe-alfaro.com>	 <40C793CE.6000609@g-house.de> <1086847636.1719.6.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1086847636.1719.6.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Felipe Alfaro Solana wrote:
| I think the mentioned error is not dependent on any specific interface
| (let it be eth0, or ppp0), but any interface in general which has a
| routing entry and is the target/source of IP traffic. This is based on
| the fact that my fixes play with the refcounting on any interface. not
| just eth0 specifically, and pertain to both IPv4 and IPv6 core.

ok.

| In my case, I was able to trigger the problem by running "cardctl eject"
| which was then stuck at D state. Killing any program using a network
| socket, and waiting for opened connections to transition from
| ESTABLISHED to TIME_WAIT and then being closed, allowed "cardctl" to
| exit the D state.

no having pcmcia here, i'll see if i can reproduce it to / see what the
patches will do.

Thanks for the explanation,
Christian.
- --
BOFH excuse #439:

Hot Java has gone cold
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAyEDH+A7rjkF8z0wRAusDAKCp2WW4LO01hP9ZDXa3N6eH7cuvIgCg2dTz
IzprZryuJ/VuiRY/DGvMH24=
=f7qL
-----END PGP SIGNATURE-----
