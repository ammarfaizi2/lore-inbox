Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263836AbRFDUt4>; Mon, 4 Jun 2001 16:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263855AbRFDUtq>; Mon, 4 Jun 2001 16:49:46 -0400
Received: from 107bus25.tampabay.rr.com ([24.94.107.25]:36734 "EHLO
	thing2.opinicus.com") by vger.kernel.org with ESMTP
	id <S263836AbRFDUt2>; Mon, 4 Jun 2001 16:49:28 -0400
Date: Mon, 4 Jun 2001 17:42:03 -0400 (EDT)
From: William Montgomery <william@opinicus.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: lowlatency 2.2.19
In-Reply-To: <20010604145650.C19113@athlon.random>
Message-ID: <Pine.LNX.3.96.1010604173410.5728A-100000@thing2.opinicus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Jun 2001, Andrea Arcangeli wrote:

> On Sun, Jun 03, 2001 at 10:38:34AM -0400, William Montgomery wrote:
> > Anyone have any ideas?  
> 
> Which options did you enabled? In theory the ikd patch could only make
> the latency worse ;), there are no performance improvements in it but
> only runtime debugging stuff.
> 
I am including a snippet from my .config:
#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y
# CONFIG_KMSGDUMP is not set
CONFIG_KERNEL_DEBUGGING=y
# CONFIG_SEMAPHORE_DEADLOCK is not set
# CONFIG_DEBUG_KSTACK is not set
# CONFIG_KSTACK_METER is not set
# CONFIG_DEBUG_SOFTLOCKUP is not set
# CONFIG_PROFILE_GCC is not set
CONFIG_TRACE=y
CONFIG_TRACE_SIZE=16384
CONFIG_TRACE_TIMESTAMP=y
# CONFIG_TRACE_TRUNCTIME is not set
CONFIG_TRACE_PID=y
CONFIG_TRACE_CPU=y
CONFIG_DEBUG_MCOUNT=y
# CONFIG_PRINT_EIP is not set
# CONFIG_MEMLEAK is not set
# CONFIG_KDB is not set

-------
I cant see anything that could make latency better either but
I can induce 1 to 2.5msec jitter in a 2.2.19 kernel with only 
lowlatency patch after a few minutes stress testing.  

The kernel with both ikd and lowlatency patches tests fine
after 24 hrs of stress testing - jitter always under 1msec.

Wm

