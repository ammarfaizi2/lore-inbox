Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbSJ1TKQ>; Mon, 28 Oct 2002 14:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJ1TKP>; Mon, 28 Oct 2002 14:10:15 -0500
Received: from bozo.vmware.com ([65.113.40.131]:28168 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261436AbSJ1TKO>; Mon, 28 Oct 2002 14:10:14 -0500
Date: Mon, 28 Oct 2002 11:17:45 -0800
From: chrisl@vmware.com
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021028191745.GA1564@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <3DB990FE.A1B8956@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB990FE.A1B8956@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 11:44:14AM -0700, Andrew Morton wrote:
> chrisl@vmware.com wrote:
> > 
> > bigmm -i 3 -t 2 -c 1024
> 
> That's a nice little box killer you have there.

Thanks. It kills on all our customer's kernel, they don't use the
bleeding edge kernel at all. It is interesting to see vmware
serve as some heavy load stress test tool. It will give some real
world load to the OS, e.g. the load need to boot a windows etc. You
can stack many of them to abuse the OS.

> 
> With mem=4G, running bigmm -i 5 -t 2 -c 1024:
> 
> 2.4.19: Ran for a few minutes, got slower and slower and
> eventually stopped.  kupdate had taken 30 seconds CPU and
> all CPUs were spinning in shrink_cache().  Had to reset.
> 
> 2.4.20-pre8-ac1: Ran for a minute, froze up for a couple of
> minutes then recovered and remained comfortable.

How many instance of bigmm left there? It should be 10 bigmm
processes before oom kickin.

> 
> 2.5.44-mm5: had a few 0.5-second stalls in vmstat output, no
> other problems.
> 
> It's probably the list search failure, but I can't say for sure
> at this time.

Chris


