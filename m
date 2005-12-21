Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVLUPuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVLUPuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVLUPuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:50:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40205 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932448AbVLUPuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:50:23 -0500
Date: Wed, 21 Dec 2005 15:50:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: gene.heskett@verizononline.net
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Another casualty of -rc6
Message-ID: <20051221155012.GG1736@flint.arm.linux.org.uk>
Mail-Followup-To: gene.heskett@verizononline.net,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <200512211039.25449.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512211039.25449.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:39:25AM -0500, Gene Heskett wrote:
>      remote           refid      st t when poll reach   delay   offset  jitter
> ==============================================================================
>  ntp2.usv.ro     80.96.120.253    2 u   59   64  377  180.742  -260483 5112.35
>  210.118.170.59  211.115.194.21   3 u   24   64  377  248.620  -260423 6261.15
>  ns1.dns.pciwest 204.123.2.5      2 u   48   64  377  126.289  -261067 4127.39
> *LOCAL(0)        LOCAL(0)        10 l   57   64  377    0.000    0.000   0.001
> drift=3.720

You have:

server 127.127.1.0     # local clock
fudge  127.127.1.0 stratum 10

in your ntp.conf, right?  I bet if you comment out those two lines ntp
will start behaving.

(I had to comment them out long ago, and I have been lead to believe that
it is wrong to include them in a configuration which is only supposed to
synchronnise to external time sources.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
