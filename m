Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263155AbTCYSMs>; Tue, 25 Mar 2003 13:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263156AbTCYSMs>; Tue, 25 Mar 2003 13:12:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:22202 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263155AbTCYSMq>; Tue, 25 Mar 2003 13:12:46 -0500
Date: Tue, 25 Mar 2003 10:23:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@digeo.com>
cc: venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <133220000.1048616630@[10.10.2.4]>
In-Reply-To: <20030324220435.GA11421@work.bitmover.com>
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com>
  <20030324200105.GA5522@work.bitmover.com> <543480000.1048540161@flay>
 <20030324153602.28b44e23.akpm@digeo.com>
 <20030324220435.GA11421@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> work ~/LMbench2/bin/i686-pc-linux-gnu ENOUGH=1000000 time bw_pipe
> Pipe bandwidth: 655.37 MB/sec
> real    0m23.411s
> user    0m0.480s
> sys     0m1.180s
> 
> work ~/LMbench2/bin/i686-pc-linux-gnu time bw_pipe
> Pipe bandwidth: 809.81 MB/sec
> 
> real    0m2.821s
> user    0m0.480s
> sys     0m1.180s

OK, is a bit more stable now ... before:

Process fork+exit: 294.4118 microseconds
Process fork+exit: 279.1500 microseconds
Process fork+exit: 280.0000 microseconds
Process fork+exit: 280.0000 microseconds
Process fork+exit: 277.2222 microseconds
Process fork+exit: 286.0000 microseconds
Process fork+exit: 277.6231 microseconds
Process fork+exit: 307.1176 microseconds
Process fork+exit: 295.4706 microseconds
Process fork+exit: 294.3529 microseconds

after:

Process fork+exit: 298.4124 microseconds
Process fork+exit: 298.6746 microseconds
Process fork+exit: 297.7784 microseconds
Process fork+exit: 294.8297 microseconds
Process fork+exit: 299.6249 microseconds
Process fork+exit: 297.6771 microseconds
Process fork+exit: 297.9801 microseconds
Process fork+exit: 293.1421 microseconds
Process fork+exit: 281.9868 microseconds

I can probably butcher that around by taking a few derived medians and
averages to get pretty consistent numbers out of it (std dev < 1% for 99%
of the time). Though 10 runs with ENOUGH=1000000 is kinda slow for all
tests, so I probably won't be able to do this by default for every version.
If there are any more suggestions on added stability, I'd love to hear them.

Is cool to have something big enough to profile too ;-)

Thanks very much,

M.

