Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268404AbSIRVMu>; Wed, 18 Sep 2002 17:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268516AbSIRVMu>; Wed, 18 Sep 2002 17:12:50 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:64486 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S268404AbSIRVMt>;
	Wed, 18 Sep 2002 17:12:49 -0400
Message-ID: <1032383868.3d88ed7c4cf2d@kolivas.net>
Date: Thu, 19 Sep 2002 07:17:48 +1000
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [BENCHMARK] contest results for 2.5.36
References: <1032360386.3d8891c2bc3d3@kolivas.net> <3D88ACB6.6374E014@digeo.com>
In-Reply-To: <3D88ACB6.6374E014@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@digeo.com>:

[snip..]

> page_add/remove_rmap.  Be interesting to test an Alan kernel too.

Just tell me which ones to test and I'll happily throw them in too.

> > Process Load:
> > Kernel                  Time            CPU
> > 2.4.19                  81.10           80%
> > 2.4.20-pre7             81.92           80%
> > 2.5.34                  71.39           94%
> > 2.5.36                  71.80           94%
> 
> Ingo ;)
>  
> > Mem Load:
> > Kernel                  Time            CPU
> > 2.4.19                  92.49           77%
> > 2.4.20-pre7             92.25           77%
> > 2.5.34                  138.05          54%
> > 2.5.36                  132.45          56%
> 
> The swapping fix in -mm1 may help here.
>  
> > IO Halfmem Load:
> > Kernel                  Time            CPU
> > 2.4.19                  99.41           70%
> > 2.4.20-pre7             99.42           71%
> > 2.5.34                  74.31           93%
> > 2.5.36                  94.82           76%
> 
> Don't know.  Was this with IO load against the same disk as
> the one on which the kernel was being compiled, or a different
> one?  This is a very important factor - one way we're testing the
> VM and the other way we're testing the IO scheduler.

My laptop which does all the testing has only one hard disk 

> > IO Fullmem Load:
> > Kernel                  Time            CPU
> > 2.4.19                  173.00          41%
> > 2.4.20-pre7             146.38          48%
> > 2.5.34                  74.00           94%
> > 2.5.36                  87.57           81%
> 
> If the IO load was against the same disk 2.5 _should_ have sucked,
> due to the writes-starves-reads problem which we're working on.  So
> I assume it was against a different disk.  In which case 2.5 should not
> have shown these improvements, because all the fixes for this are still
> in -mm.  hm.  Helpful, aren't I?

It's the same disk. These are the correct values after I've fixed all known
problems in contest. I need someone else to try contest with a different disk.
Helpful? This is all new so it will take a while for _anyone_ to understand
exactly what's going on I'm sure. Since we haven't had incremental benchmarks
till now, who knows what it was that made IO full mem drop from 146 to 74 in the
first place?

Con.
