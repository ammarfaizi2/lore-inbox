Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVBVQ1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVBVQ1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 11:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVBVQ1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 11:27:46 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:62633 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261151AbVBVQ1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 11:27:44 -0500
Message-ID: <421B5D73.9020505@g-house.de>
Date: Tue, 22 Feb 2005 17:27:31 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Leigh Brown <leigh@solinno.co.uk>, Sebastian Heutling <sheutlin@gmx.de>,
       Tom Rini <trini@kernel.crashing.org>, Meelis Roos <mroos@linux.ee>,
       linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII  Utah)
 PCI IRQ map
References: <20041206185416.GE7153@smtp.west.cox.net>	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>	<421B1F12.7050601@gmx.de> <5982.195.212.29.67.1109074991.squirrel@195.212.29.67>
In-Reply-To: <5982.195.212.29.67.1109074991.squirrel@195.212.29.67>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Leigh Brown wrote:
>>>It detects the HBA, tries device discovery, gets a timeout, ABORT,
>>>timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and
>>>there it hangs.

it does not really hang, it just tries to initialize every target of the
HBA (here: from sym0:0:0: to sym0:15:0, see [1] for more info) and it is
so busy with it that the bootprocess seems to hang. after failing with the
last target, booting continues just fine. (i have no disks attached,
booting via nfsroot)

> Ah, this could well be my fault.  Those patches were to improve support
> of IBM RS/6000 PReP boxes.  Do those machines have residual data?  If
> so, could anyone who has one send me the contents of /proc/residual?
> 
> Also, a full boot log when working and failing would be cool.

[1] it's all here: http://nerdbynature.de/bits/hal/2.6.11-rc3/

(yes, they are from different dates, but the setup is the same. the
kernelversion from messages is 2.6.11-rc2, the rest is all 2.6.11-rc3,
from vanilla (-BK) sources)

thanks,
Christian.
- --
BOFH excuse #67:

descramble code needed from software company
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCG11y+A7rjkF8z0wRAvMoAKCWliE97XWNmFv+xf7d3yU5vN3tDQCffMCj
Y8hf0xXrOsCA6WkZUPKkUa0=
=ECSk
-----END PGP SIGNATURE-----
