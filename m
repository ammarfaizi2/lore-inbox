Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbSLFH0i>; Fri, 6 Dec 2002 02:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267681AbSLFH0i>; Fri, 6 Dec 2002 02:26:38 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:43153
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267678AbSLFH0h>; Fri, 6 Dec 2002 02:26:37 -0500
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3DF050EB.108DCF8@digeo.com>
References: <3DF049F9.6F83D13@digeo.com>
	 <1039158861.16565.10.camel@localhost>  <3DF050EB.108DCF8@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1039160042.16565.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Dec 2002 01:34:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 01:25, Andrew Morton wrote:
> GrandMasterLee wrote:
> > 
[...]
> > Just curious, but how long would it take a system with 8GB RAM, using 4G
> > or 64G kernel to fall over?
> 
> A few seconds if you ran the wrong thing.  Never if you ran something
> else.
> 
> > One thing I've noticed, is that 2.4.19aa2
> > runs great on a box with 8GB when I don't allocate all that much, but
> > seems to run into issues after a large DB has been running on it for
> > several days. (i.e. the system get's generally a little slower, less
> > responsive, and in some cases crashes after 7 days).
> 
> "crashes"?  kernel, or application?   What additional info is
> available?

Machine will panic. I've actually captured some and sent them to this
list, but I've been told that my stack was corrupt. Problem is, ATM, I
can't find a memory problem. Memtest86 locks up on test 4(as in, machine
needs hard booting), no matter if it's 8GB or 4GB RAM installed. An no
matter if *known good* ram is being tested as well. So I don't think
it's that per se. 

> > Yes, I know, sounds like a memory leak in something, but aside from
> > patching Oracle from 8.1.7.4(dba's can't find any new patches ATM), I've
> > tried everything except changing my kernel.
> > 
> > Could this be similar behaviour?
> 
> No, it's something else.  Possibly a leak, possibly vma structures.

Could that yield a corrupt stack?

> You should wait until the machine is sluggish, then capture
> the output of:
> 
> 	vmstat 1
> 	cat /proc/meminfo
> 	cat /proc/slabinfo
> 	ps aux

I shall gather the information sometime 12/06/2002. TIA

--The GrandMaster
