Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSEaS3G>; Fri, 31 May 2002 14:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSEaS3F>; Fri, 31 May 2002 14:29:05 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:34784 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316544AbSEaS3D>; Fri, 31 May 2002 14:29:03 -0400
Date: Fri, 31 May 2002 11:28:47 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ian Collinson <icollinson@imerge.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
Message-ID: <20020531112847.B1529@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C992@imgserv04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 06:54:46PM +0100, Ian Collinson wrote:
> 
> 	We're having problems with realtime scheduling (SCHED_RR and
> SCHED_FIFO), on 2.4 kernels >= 2.4.10 (built for i386, no SMP).  We have an
> app that uses real-time scheduled threads. To aid debugging, in case of
> realtime threads spinning and locking the system, we always keep a bash
> running on a (text) console, at SCHED_RR, priority 99 (a higher priority
> than any threads in our app).  We test that this is a valid approach by
> running a lower priority realtime app, on another console, that sits in an
> infinite busy loop.  This has always worked, and we've been able to
> successfully use the high-priority bash to run gdb, and so on.  This is also
> what the man page for sched_setscheduler suggests, to avoid total system
> lock up.

<snip>

> 	Then I switch back to the first console, with its priority 99 bash.
> I am able to type away for 10 seconds, until the priority 50 process starts,
> at which point the shell locks up.   I can get the same effect on one
> console with:
> 
> 	> ( sleep 10; realtime -rr 50 eat_cpu ) & realtime -rr 99 bash
> 
> 	Previously, the high-priority shell would never lock up.  Now it
> does.

This works fine for me on 2.4.17 with a SERIAL console.  Could this
be related to some differences (new features) in the VGA console?
I am totally ignorant of how the consoles work.

-- 
Mike
