Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSBFVay>; Wed, 6 Feb 2002 16:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSBFVao>; Wed, 6 Feb 2002 16:30:44 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:12168 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S290818AbSBFVa1>; Wed, 6 Feb 2002 16:30:27 -0500
Date: Wed, 6 Feb 2002 16:34:20 -0500
To: riel@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020206213420.GA24571@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 09:44:33AM -0200, Rik van Riel wrote:
> Once you get over 'dbench 16' or so the whole thing basically
> becomes an excercise in how well the system can trigger task
> starvation in get_request_wait.

It's neat you've identified that bottleneck.  

dbench 192 also appears to trigger more swapin/swapout than 
usual with rmap based kernels about 12-15 minutes into the test;
and it remains unusually high for the duration of the run.  
(not a huge amount of swapping, but vmstat 60 shows double digit
numbers, rather than the more typical 0 with occasional single
digits "spikes").  dbench 64 doesn't trigger this behavior on 
my test box.

I want diversity in the workloads.  bonnie++ does a single
thread, and tiobench is doing 1, 2, 4, and 8 threads.  dbench
fits in well at the other end of the spectrum.

The newest bench added to the lineup is OSDB on postgresql.
If everything executes properly, 2.5.3-dj3 (which includes
radix-tree) will win the first timer award for OSDB. :)

-- 
Randy Hron

