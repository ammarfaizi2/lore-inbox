Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbQKPXeQ>; Thu, 16 Nov 2000 18:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130692AbQKPXeG>; Thu, 16 Nov 2000 18:34:06 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:9993 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S130073AbQKPXeE>; Thu, 16 Nov 2000 18:34:04 -0500
Date: Thu, 16 Nov 2000 23:02:35 +0000 (GMT)
From: Peter Denison <peterd@pnd-pc.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Which compiler to use?
Message-ID: <Pine.LNX.4.21.0011162255460.1527-100000@pnd-pc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the broken references - I read l-k through Kernel Traffic.

> At one point someone asked what the recommended compiler was for all the
> various kernel versions, and Peter Samuelson [*] listed:
> 
> 2.91.66 aka egcs 1.1.2. It has been officially blessed for 2.4 and has
> been given an informal thumbs-up by Alan for 2.2. (It does NOT work for
> 2.0, if you still care about that.)
> 
> 2.7.2.3 works for 2.2 (and 2.0) but NOT for 2.4. 
> 
> 2.95.2 seems to work with both 2.2 and 2.4 (no known bugs, AFAIK) and
> many of us use it, but it is a little riskier than egcs. 
> 
> Red Hat "2.96" or CVS 2.97 will probably break any known kernel. 

Please note that 2.91.66 WILL NOT correctly build any bit of 2.4 (or
probably 2.2) on i386 that uses the kernel version of strstr, because of a
register allocation bug. This currently affects the DEPCA driver, but very
few other things.

2.95.2 is OK in this instance and elsewhere for me (YMMV).

Whether this means we should change the recommended compiler version, or
get rid of the use of (or change) the in-kernel strstr is a subject left
open for debate.

-- 
Peter Denison <peterd@pnd-pc.demon.co.uk>
Linux Driver for Promise DC4030VL cards.
See http://www.pnd-pc.demon.co.uk/promise/promise.html for details


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
