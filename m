Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSDIO23>; Tue, 9 Apr 2002 10:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSDIO23>; Tue, 9 Apr 2002 10:28:29 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:12298 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S290797AbSDIO22>; Tue, 9 Apr 2002 10:28:28 -0400
Date: Tue, 9 Apr 2002 10:28:27 -0400 (EDT)
From: Vince Weaver <vince@deater.net>
X-X-Sender: <vince@hal.deaternet.vmw>
To: <linux-kernel@vger.kernel.org>
Subject: Re: system call for finding the number of cpus??
In-Reply-To: <a8t3qk$cga$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.31.0204091022001.9726-100000@hal.deaternet.vmw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Apr 2002, H. Peter Anvin wrote:
> By author:    Christoph Hellwig <hch@infradead.org>
> > On Mon, Apr 08, 2002 at 05:25:08PM -0400, Robert Love wrote:
> > > Linux does not implement such a syscall.  Note
> > >
> > > 	cat /proc/cpuinfo | grep processor | wc -l
> >
> > I guess there is at least one architecture on which it breaks..
> >
>
> Then that architecture should be fixed.

Back in 1999 or so I actually came up with a patch that more-or-less came
up with an arch-independent /proc/cpuinfo file.  It touched off a
mini-flamewar on linux-kernel, none of the arch maintainers wanted to
change their pet format, and Linus silently dropped the patch.

As maintainer of linux_logo I have to have a separate cpuinfo parser for
each architecture.

For number of CPU's..... x86 uses the "count processor/bogomips" type
thing.  Some architectures actually have an "active cpus:" type field.
Some have a "processors total:" type field.  And often the method that
works changes from kernel to kernel, sometimes even within stable
releases.

But no, counting processors or bogomips doesn't work across the board.

Should this be rectified somehow?  I think it would take a proclomation
from on high.

What to do in the meantime?  Well the sysconf() method sounds promising.
If not you can dig out the sysinfo library included with linux_logo which
does a reasonable job with most of the common architectures.

Vince

-- 
____________
\  /\  /\  /  Vince Weaver        Linux 2.4.9 on a K6-2+, Up 45 days
 \/__\/__\/   vince@deater.net    http://www.deater.net/weave


