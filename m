Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbSJ2GlA>; Tue, 29 Oct 2002 01:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJ2Gk7>; Tue, 29 Oct 2002 01:40:59 -0500
Received: from alpha1.cc.monash.edu.au ([130.194.1.1]:56588 "EHLO
	ALPHA1.CC.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S261610AbSJ2Gk6>; Tue, 29 Oct 2002 01:40:58 -0500
Date: Tue, 29 Oct 2002 17:10:12 +1100 (EST)
From: netdev-bounce@oss.sgi.com
To: undisclosed-recipients:;
Message-id: <20021029061012.ACCDA12CEA6@blammo.its.monash.edu.au>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Nivedita Singhvi wrote:

> "Richard B. Johnson" wrote:
> 
> > No. It's done over each word (short int) and the actual summation
> > takes place during the address calculation of the next word. This
> > gets you a checksum that is practically free.
> 
> Yep, sorry, word, not byte. My bad. The cost is in the fact 
> that this whole process involves loading each word of the data
> stream into a register. Which is why I also used to consider
> the checksum cost as negligible. 
> 
> > A 400 MHz ix86 CPU will checksum/copy at 685 megabytes per second.
> > It will copy at 1,549 megabytes per second. Those are megaBYTES!
> 
> But then why the difference in the checksum/copy and copy?
> Are you saying the checksum is not costing you 864 megabytes
> a second??

Costing you 864 megabytes per second?
Lets say the checksum was free. You are then able to INF bytes/per/sec.
So it's costing you INF bytes/per/sec?  No, it's costing you nothing.
If we were not dealing with INF, then 'Cost' is approximately 1/N, not
N. Cost is work_done_without_checksum - work_done_with_checksum. Because
of the low-pass filter pole, these numbers are practically the same.
But, you can get a measurable difference between any two large numbers.
This makes the 'cost' seem high. You need to make it relative to make
any sense, so a 'goodness' can be expressed as a ratio of the cost and
the work having been done.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America



