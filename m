Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278649AbRKHWEJ>; Thu, 8 Nov 2001 17:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278662AbRKHWD7>; Thu, 8 Nov 2001 17:03:59 -0500
Received: from imsp.terry.uga.edu ([128.192.28.146]:58379 "EHLO
	ember.terry.uga.edu") by vger.kernel.org with ESMTP
	id <S278660AbRKHWDu>; Thu, 8 Nov 2001 17:03:50 -0500
To: linux-kernel@vger.kernel.org (Linux kernel)
Subject: test SYN cookies (was Re: SYN cookies security bugfix?)
In-Reply-To: <E161oM3-0007Xm-00@the-village.bc.nu>
From: Ed L Cashin <ecashin@terry.uga.edu>
Date: 08 Nov 2001 17:00:30 -0500
In-Reply-To: <E161oM3-0007Xm-00@the-village.bc.nu>
Message-ID: <m3y9lgkjnl.fsf@terry.uga.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I received a forwarded message from SuSE regarding a security vulnerability
> > with respect to randomization of the ISN for SYN cookies - or something to
> > that effect.  I have not been able to find the patch which addresses this
> > problem; if anyone can point me towards it, I would be appreciative.
> 
> Its fixed in 2.2.20, you can grab the 2.2 patch from there

What is a good way to test SYN cookies?  I can induce a three-second
delay (on victim host V) before new TCP connections are accepted by
sending a burst of 2000 SYN packets (from attacker A), where V is
running a 2.2.14 or 2.2.17 kernel.  During the three seconds ICMP echo
requests from A to V are being answered.

Turning on SYN cookies after /proc is mounted does not affect the
three-second pause, though, so I figure that either the pause is not
on account of a full half-open connection queue or SYN cookies are not
working.

-- 
--Ed Cashin                   PGP public key:
  ecashin@terry.uga.edu       http://www.terry.uga.edu/~ecashin/pgp/

