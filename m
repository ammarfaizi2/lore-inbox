Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTEZSgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTEZSgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:36:43 -0400
Received: from smtp.inet.fi ([192.89.123.192]:1947 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S262016AbTEZSgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:36:42 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: [2.4.20-ck7] good compressed caching experience
Date: Mon, 26 May 2003 21:50:03 +0300
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305262150.04552.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I just decided to tell everyone that I've been able to run 2.4.20-ck7 with 
compressed caching enabled in my little brother's Pentium 133MHz, for hours, 
doing stress testing, compiling kernels and using the Internet under X.

I had pre-empt enabled.  Compressed swap worked also.  I used 4kB pages 
without compressed swap, and 8kB with it.

This was with Con's ck7pre versions released on 24th and 25th of May.

Now running 2.4.20-ck7pre with compressed cache in a dual CPU machine with SMP 
disabled (compressed caching and SMP support are still mutually exclusive), 
1GB of RAM but "mem=128M" for testing purposes.  Been stable for 6 hours now, 
and done even some stress testing.  Try 128 instances of burnBX with 1MB 
each, like "for ((A=128;A--;A<1)) do burnBX J & done".  A nice brute force or 
"if you don't behave I'll push all my buttons" method :)

Wondering if Pentium 133MHz (64MB RAM) is fast enough to benefit from 
compressed caching.  I know there's a limit, depending on the speed of the 
CPU and the speed of the swap partition (doing random accesses), which 
determines if compressed caching is beneficial or not.

This machine has a Seagate Barracuda V 80GB, which does sequential reads at 
40MB/s.  I could drive this into trashing, then type "sar -B 1 1000" and see 
how the swap is doing.  Now, compressed caching brings me benefit if, and 
only if, it can compress and decompress pages faster than that in this CPU, 
which it sure does, since this is a Pentium III 933MHz, but I'm not sure 
about the little brother's Pentium 133MHz.  It has a 4GB Seagate that does 
6MB/s sequentially.  Did I figure it out correctly?  Of course swapping to a 
partition gets slower as the swap usage increases.  Longer seeks and the 
like.

Just a warning... both systems have only ReiserFS partitions.  Other FSes 
might still get hurt.

-Kimmo Sundqvist
