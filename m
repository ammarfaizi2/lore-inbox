Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314359AbSDROIN>; Thu, 18 Apr 2002 10:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314363AbSDROIM>; Thu, 18 Apr 2002 10:08:12 -0400
Received: from smtp-server6.tampabay.rr.com ([65.32.1.43]:49135 "EHLO
	smtp-server6.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S314359AbSDROIL>; Thu, 18 Apr 2002 10:08:11 -0400
Date: Thu, 18 Apr 2002 10:06:22 -0400
From: Rick Haines <rick@kuroyi.net>
To: linux-kernel@vger.kernel.org
Subject: read latency (ia64)
Message-ID: <20020418140622.GA31405@sasami.kuroyi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Lion with 4 666mhz B3 stepping cpus and 4GB ram running Debian
unstable with kernel 2.4.18 and the 020410 ia64 patch (I have the same
problem with 2.4.9-itanium-smp from the archive).

I have a program that reads large files in increments of 81920 blocks.
After about 9600 read calls I get about a dozen reads that take about 3 
seconds each.  Does anyone have any ideas as to a cause/solution?
(I have 4 other threads working/possibly writing output at the same 
time, although in this case only 1 of them would be active at 
the same time).  I am also running a program that callocs almost all my 
ram to make sure none of the file is cached.

I can provide more info if necessary.
Here is a partial log I made (read#/time in seconds):

9597 2.823812008
9598 0.009531000
9599 0.000220000
9600 0.010351000
9601 0.014768000
9602 0.000213000
9603 2.910599947
9604 0.009694000
9605 0.000193000
9606 0.014762000
9607 0.000193000
9608 0.009892000
9609 2.869304895
9610 0.000717000
9611 0.014134000
9612 0.010046000
9613 0.000200000
9614 0.009780000
9615 0.000200000
9616 2.974085093

Thanks for your help.

-- 
Rick (rick@kuroyi.net)
http://dxr3.sourceforge.net
http://rsub.sourceforge.net

I think the slogan of the fansubbers puts
it best: "Cheaper than crack, and lots more fun."
