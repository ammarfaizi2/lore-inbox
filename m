Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131202AbRCMWF6>; Tue, 13 Mar 2001 17:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131210AbRCMWFS>; Tue, 13 Mar 2001 17:05:18 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:24070 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S131202AbRCMWCo>;
	Tue, 13 Mar 2001 17:02:44 -0500
Date: Tue, 13 Mar 2001 15:02:35 -0700
From: Nathan Paul Simons <npsimons@fsmlabs.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
Message-ID: <20010313150235.A12677@fsmlabs.com>
Reply-To: npsimons@fsmlabs.com
In-Reply-To: <20010312195647.A32437@fsmlabs.com> <200103132105.f2DL5D8411265@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200103132105.f2DL5D8411265@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Mar 13, 2001 at 04:05:13PM -0500
X-Bad-Disk-Header: Do you ever get that syncing feeling?
Organization: Finite State Machine Labs <http://www.fsmlabs.com/>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 04:05:13PM -0500, Albert D. Cahalan wrote:
> Bloat removal: being able to run without /proc mounted.
> 
> We don't have "kernel speed". We have kernel-mode screwing around
> with text formatting.

	Or calculating things that really should be taken care of in
user space, such as CPU utilization.

> This isn't just for him. Many people have wanted it.

	Yes, but how many people would actually *use* it?  How many
programs out of the thousands out there would benefit from this?
If it's more than 50 widely used packages, I'd be more than happy
to see something that speeds them all up added to the kernel.

> 1. variable-length ASCII strings with undefined ad-hoc syntax

	Use enumerated string functions, always.

> 2. array of fixed-size (64-bit) values

	It's an array?  That can still be overflowed by sloppy 
programming.  When it comes right down to it, I'd rather have 
something that could potentially die badly be run on the user
side, rather than the kernel side.

> Parsing costs programmer time.

	But it's fairly easy to do in any number of programming
languages besides C which can't be easily used in the kernel.
Not to mention parsing libraries for C that fit much better on
the user side because they would make the kernel huge and slow
if compiled into it.
	Last but not least, I don't want to waste time in kernel
scanning through a list of syscalls a mile long, half of them
I don't ever use.  Or having a kernel that's so big that you
can't fit it on embedded systems anymore.  And once you start
adding every "nifty" syscall that comes along, that's what
will happen.  So again, I say give us all a really good reason
for this syscall, or just hack it into your own kernels and 
let us have our speedy, small vanilla kernels.
