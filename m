Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319008AbSHMUDT>; Tue, 13 Aug 2002 16:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319011AbSHMUDS>; Tue, 13 Aug 2002 16:03:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47079 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319008AbSHMUDQ>;
	Tue, 13 Aug 2002 16:03:16 -0400
Date: Tue, 13 Aug 2002 13:04:03 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Message-ID: <2012000000.1029269043@flay>
In-Reply-To: <Pine.LNX.4.44.0208131220350.7411-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208131220350.7411-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, I was being unclear, that's not really what I meant. If I may rephrase:
>> I don't like the performance hit it gives on P3 standard SMP machines (not
>> NUMA-Q) though it does work on there too, and there's no easy way for 
>> people to disable it.
> 
> Well, it makes performance _so_ much better on a P4 that it's not even 
> funny. It's basically a "P4 is unusable with SMP" without it.

Right, accepted. But if it's good for P4, and bad for P3 (at least for some 
workloads), surely this leads to the conclusion that it should be a config 
option (probably defaulting to being on)? If you can see another way to
solve the conundrum ....

I can understand you didn't like the negative stuff, but there's a choice 
between two evils ... - some mess in the config.in file, and having a sensible
default. We will cut that one whichever way you like (though I can't help
thinking I'm missing some obvious default thing in the config language).

If you still hate it, the other option I can see is to cut a minimal patch for now, 
which institutes a CONFIG_IRQ_BALANCE, but just decides that off the existing
config options, rather than asking any more questions. Then we'll look at
the perf problems seperately, and see if we can fix them - people can force
it off by editing the .config file by hand if they want until then.

M.
