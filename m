Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131707AbQKNXgz>; Tue, 14 Nov 2000 18:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131710AbQKNXgf>; Tue, 14 Nov 2000 18:36:35 -0500
Received: from lsne-cable-1-p21.vtxnet.ch ([212.147.5.21]:33551 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S131711AbQKNXgZ>;
	Tue, 14 Nov 2000 18:36:25 -0500
Date: Wed, 15 Nov 2000 00:06:10 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Message-ID: <20001115000610.F8753@almesberger.net>
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil> <3A117311.8DC02909@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A117311.8DC02909@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Tue, Nov 14, 2000 at 12:14:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell wrote:
> 2) Continuous operation analogous to power & telephone services. 
> 
> No way. Multics could have a whole bank of memory fail and keep running.
[...]

Considering that it's very cheap nowadays to have redundancy at the
box level, designs attempting to achieve robustness at the component
level may fail to benefit from changes in the hardware market in the
last few decades. Maybe we need a Beowulf for fault tolerance ...

> 3) A wide range of system configurations, changeable without system or
> user program reorganization. 

I'd say we're largely there: /proc/sys and modules give you a lot of
freedom, if properly used.

> See comments in #2. Plus, the recent two-kernel-monte, linux-from-linux
> type stuff would be especially excellent if it will allow the kernel to
> be upgraded on the fly.

Difficult, because there's no reliable (= automated) means of tracking
data structures an the semantics of internal interfaces from kernel to
kernel. Feasible for selected subsystems and with coarse granularity,
though. (E.g. modules.)

> console ACLs, etc. If there's a function, it probably needs an ACL.

Empirical evidence with VMS suggests that overly sophisticated
security mechanisms can actually decrease overall security, because
they may lead people to micro-manage security and to neglect the
overall security concept.

> 7) Support for a wide range of applications. 
> 
> Well... anything wih source or compiled for the Linux ABI. A
> microkernel-type architecture with servers would provide a lot more of
> this. See QNX, NT, Mach.

Hmm, I don't think you want to say this :)

> 9) The ability to evolve the system with changes in technology and in
> user aspirations.

That's perhaps the most important point. The computing environment
has changed a lot. Take for example Google's PC farm and compare
this with the mainframe approach one would have chosen twenty or
thirty years ago. Mainframes are still the right answer for some
problems, but their role in the solution may be very different from
the days when they were the only solution, and all of the solution.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
