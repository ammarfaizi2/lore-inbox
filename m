Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUBSHhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 02:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUBSHhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 02:37:23 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:32151 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S266194AbUBSHhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 02:37:21 -0500
Message-ID: <403467A2.6020402@g-house.de>
Date: Thu, 19 Feb 2004 08:37:06 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-crypto@nl.linux.org
Subject: Re: 2.4.24 + cryptoloop: __alloc_pages: 5-order allocation failed
References: <40317785.3060509@g-house.de> <Pine.LNX.4.58L.0402182037320.11790@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402182037320.11790@logos.cnet>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcelo Tosatti wrote:
|
| Please do
|
| echo 1 > /proc/sys/vm/vm_gfp_debug
|

unfortunately i am not able to do this right now, i'll have access to
the machine on sunday i guess. so i have to wait what it gives then.

| I suspect the problem is loop allocates its buffers in a way so that the
| allocator can't sleep waiting for IO, which in turn overloads the memory
| and causes the failures.

yes, i've heard rumors too that the loop device was not so good at all
when it comes to high i/o throughput.

Thanks,
Christian.
- --
BOFH excuse #63:

not properly grounded, please bury computer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFANGeh+A7rjkF8z0wRApHdAKDHxhC2WdWbSQGROyY0vhIl0pdTUwCg0+aV
UESKUigO8UARal6xi+NzqHQ=
=nwc6
-----END PGP SIGNATURE-----
