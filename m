Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135795AbREIXF1>; Wed, 9 May 2001 19:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135810AbREIXFS>; Wed, 9 May 2001 19:05:18 -0400
Received: from pop.gmx.net ([194.221.183.20]:36010 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135795AbREIXFI>;
	Wed, 9 May 2001 19:05:08 -0400
Message-ID: <3AF9B0D2.F2E330F9@gmx.de>
Date: Wed, 09 May 2001 23:04:18 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
In-Reply-To: <lm@bitmover.com> <200105090424.AAA05768@soyata.home> <20010508222210.B14758@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> Let's review:  ECC is nice, but it doesn't solve all data corruption
> problems.  Applications which do their own end to end data integrity
> checks will catch many more error cases than what ECC catches.

I think you have a wrong idea why the ECC is there.  ECC deals with
the inherit shortcommings of DRAM.

DRAMs are not perfect.  They have a probability to lose a bit.
Normally this probability is low enough to live with it.  Lets say
you have a system with 1MByte and let's say the probability for a
single bit error is around 1 error in 100 years.  Good enough.
Now put 1GByte in the system. You'll get a probability of 10 errors
per year.  Maybe good enough for a Windows box but not acceptable
for your server.  So you put in ECC to bring this probability back
into reasonable numbers.  ECC can correct the single bit errors.
You only have to deal with double bit errors.  Chance for them is
much much lower.

Sure, it doesn't solve all data corruption problems - only simple
errors in DRAMs.  But it makes systems with huge amount of RAM staying
up alive much longer.  And btw, your integrity checks over data will
not protect against a corrupted kernel or application...

Ciao, ET.

PS: Just let your app run long enough.  I'm sure it will detect a
checksum error some day ;-)

