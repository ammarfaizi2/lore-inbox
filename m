Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSJLUUy>; Sat, 12 Oct 2002 16:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261348AbSJLUUy>; Sat, 12 Oct 2002 16:20:54 -0400
Received: from web11908.mail.yahoo.com ([216.136.172.192]:35346 "HELO
	web11908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261347AbSJLUUx>; Sat, 12 Oct 2002 16:20:53 -0400
Message-ID: <20021012202642.53345.qmail@web11908.mail.yahoo.com>
Date: Sat, 12 Oct 2002 13:26:42 -0700 (PDT)
From: Zapp Foster <zzaappp@yahoo.com>
Subject: Performance improvement inquiry
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a situation where speed of processing of
network data through a LINUX cluster is extremely 
crucial, and I need to shave 10 to 20 msec.

At the moment, I am running a stock REDHAT 7.1
distro with the more obviously unused modules
removed (like firewall services since the cluster 
resides behind a firewalled router, etc).

First question:  Will compiling a kernel with
the network module resident (as opposed to a loadable
module) make network performance any better?  From
the reading, it appears that resident modules are only
faster in initialization, not runtime.  I'm new to
this, so please correct me if I'm wrong.

Second:  Threads.  Each server runs one to several
custom services I've written, each of which performs a
part of data processing on the incoming data.  Each
service consists of eight to thirty threads.  The
question:  Is there a way to tweak the kernel to
improve thread performance?  I hear the 2.5 kernel 
has thread performance improvements, but I don't want 
to mess with it until I know more about it, or it 
goes into release as v2.6.

Third:  Shared libraries and task switching.  My fear
is that overhead for kernel/OS and my custom services
may be grinding away at the disk drive unnecessarily. 
Using sar(1), I see that no swap space is being used,
so I'm not hitting virtual memory.  But I wonder
how likely it is that shared libs (used either by my
services or the kernel/OS) are being re-read from
disk?  I am hoping that the libs get cached and thus
load from cache back into memory.

Fyi:  Each server contains a dual CPU and either 500MB
of RAM or a full Gig.  All machines are networked with
100baseT NICs.  Pings between each server is down
around 10 to 30 usec, so I don't think our local
backbone is a significant issue.

The desired result is to shave off the full 20 msec. 
If anyone knows about kernel futzing that will gain me
some performance, I'd love to hear it!

Many thanks!

-zap

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
