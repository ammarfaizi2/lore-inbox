Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUGMOc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUGMOc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUGMOcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:32:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:29912 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265256AbUGMOcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:32:21 -0400
X-Authenticated: #19232476
Subject: Re: DriveReady SeekComplete Error...
From: Dhruv Matani <dhruvbird@gmx.net>
To: Evaldo Gardenali <evaldo@gardenali.biz>, justin.piszcz@mitretek.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40F3D4AC.9050407@gardenali.biz>
References: <1089721822.4215.3.camel@localhost.localdomain>
	 <40F3D4AC.9050407@gardenali.biz>
Content-Type: text/plain
Organization: 
Message-Id: <1089729992.3594.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Jul 2004 20:17:33 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing I forgot to mention is that if I use that hard 80-pin
cable, then I do not get such errors at boot time, but get them when
some service is loading, and if I use the cheaper more flexible
cable(with possibly lesser number of cables), then I get these errors
while the kernel is loading as well as when some service is loading.
That service is smartd.

Again, only in 2.4.20-8, in the previous version(the default that came
with RedHat-7.2), there is no such problem. Also, I use a re-compiled
version of the 2.4.20-8 kernel, whereas the default RedHat provided one
for 7.2, but the errors persist even for the default RedHat-9 kernel
2.4.20-8, so I suspect that it's a kernel thing.

One more thing! In RedHat-9 with 2.4.20-8, sometimes, the number of
processes just increases like mad! and the whole system becomes
unstable. Then I get errors like I/O error, and hda can not be read
from, and a whole list of blocks.



On Tue, 2004-07-13 at 17:55, Evaldo Gardenali wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dhruv Matani wrote:
> | Hi,
> | 	I've been getting this error for my brand new (2 months old) Samsung
> | HDD. The model Number is: SV0411N, and it is a 40GB disk. I'm using the
> | kernel version 2.4.20-8 provided by RedHat. When I used RH-7.2(before
> | upgrading to RH-9), the same HDD worked fine. Also, when I re-installed
> | RH-7.2, it worked fine?
> |
> | Any suggestions?
> |
> | Please cc me the reply, sine I'm not subscribed.
> | Thanks ;-)
> |
> 
> Hi there!
> on your kernel config, make sure you enable this:
> 
> 
> ~  lqqqqqqqqqqqqqqqqqqqqqqq Use multi-mode by default
> qqqqqqqqqqqqqqqqqqqqqqqk
> ~  x CONFIG_IDEDISK_MULTI_MODE:
> ~    x
> ~  x
> ~    x
> ~  x If you get this error, try to say Y here:
> ~    x
> ~  x
> ~    x
> ~  x hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
> ~    x
> ~  x hda: set_multmode: error=0x04 { DriveStatusError }
> ~    x
> ~  x
> ~    x
> ~  x If in doubt, say N.
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> 
> tqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq(100%)qqu
> 
> ~  x                                < Exit >
> ~    x
> 
> mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> 
> iD8DBQFA89Ss5121Y+8pAbIRAio8AJ4sJ1ekYRSwVEoGBE90QIITqQyg0wCfXFaE
> npdo42iFQ0Le8Fzq7sXjGUg=
> =4aFw
> -----END PGP SIGNATURE-----
-- 
        -Dhruv Matani.
http://www.geocities.com/dhruvbird/

As a rule, man is a fool. When it's hot, he wants it cold. 
When it's cold he wants it hot. He always wants what is not.
	-Anon.


