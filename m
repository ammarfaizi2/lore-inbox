Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUDEULq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUDEULq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:11:46 -0400
Received: from web61108.mail.yahoo.com ([216.155.196.110]:14451 "HELO
	web61108.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263178AbUDEULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:11:41 -0400
Message-ID: <20040405201139.73032.qmail@web61108.mail.yahoo.com>
Date: Mon, 5 Apr 2004 13:11:39 -0700 (PDT)
From: Eyal Lotem <gnupeaker@yahoo.com>
Subject: Re: [coLinux-devel] coLinux benchmarks
To: Dan Aloni <da-x@colinux.org>,
       Cooperative Linux Development 
	<colinux-devel@lists.sourceforge.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040405131520.GA4395@callisto.yi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, I stumbled upon this when checking my mail :)

I think the reason may be that Windows is using the
disks better and making access faster. Perhaps DMA
acceleration or some other feature is turned off on
the Linux host side, making disk access slower on the
Linux side.

Then again, that could only explain the first run of
the benchmark and not the cached runs.  Maybe some bug
in Linux's caching/buffering?

--- Dan Aloni <da-x@colinux.org> wrote:
> Hello,
> 
> Today I ran some dbench2 benchmarks in order to test
> coLinux's
> (http://www.colinux.org) virtual disk I/O
> performance.
> 
> I'm cross-posting this message to the LKML, as I
> know that on that
> list there are some benchmarking experts or other
> people who may 
> find this interesting.
> 
> This is the output from a coLinux 2.4.25 guest VM
> configured with 
> 128MB RAM running on a Linux 2.6.3 (BK) host that
> has a total of 
> 256MB RAM. The host machine has a Mobile Intel
> Celeron CPU (2.20GHz). 
> All filesystems used are ext3.
> 
>     colinux:/home/dax# dbench 5 -s -S
>     5 clients started
>        0     62477  10.01 MB/sec
>     Throughput 10.0026 MB/sec (sync open) (sync
> dirs) 5 procs
> 
>     colinux:/home/dax# dbench 5 -s -S
>     5 clients started
>        0     62477  10.43 MB/sec
>     Throughput 10.4262 MB/sec (sync open) (sync
> dirs) 5 procs
> 
>     colinux:/home/dax# dbench 5 -s -S
>     5 clients started
>        0     62477  10.90 MB/sec
>     Throughput 10.8926 MB/sec (sync open) (sync
> dirs) 5 procs
> 
> 
> I then ran the same thing on the host itself,
> *without* the 
> coLinux VM running in the background:
> 
>     hostile17:~/colinux# dbench 5 -s -S
>     5 clients started
>        0     62477  5.08 MB/sec
>     Throughput 5.07573 MB/sec (sync open) (sync
> dirs) 5 procs
>     
>     hostile17:~/colinux# dbench 5 -s -S
>     5 clients started
>        0     62477  5.13 MB/sec
>     Throughput 5.12705 MB/sec (sync open) (sync
> dirs) 5 procs
> 
> 
> The VM shows better results than the host. What
> gives? Perhaps
> it is because of the combination of the host and
> guest's buffer 
> cache? I'd like to know about more percise
> benchmarking methods 
> for VMs.
> 
> -- 
> Dan Aloni
> Cooperative Linux, lead developer
> da-x@colinux.org
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux
> Tutorials
> Free Linux tutorial presented by Daniel Robbins,
> President and CEO of
> GenToo technologies. Learn everything from
> fundamentals to system
>
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> coLinux-devel mailing list
> coLinux-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/colinux-devel


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
