Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTDHTgL (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTDHTgK (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:36:10 -0400
Received: from almesberger.net ([63.105.73.239]:31241 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261620AbTDHTgJ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 15:36:09 -0400
Date: Tue, 8 Apr 2003 16:47:18 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Paul Larson <plars@linuxtestproject.org>
Cc: Andi Kleen <ak@suse.de>, Robert Williamson <robbiew@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, aniruddha.marathe@wipro.com,
       ltp-list@lists.sourceforge.net
Subject: Re: [LTP] Re: Same syscall is defined to different numbers on 3 different archs(was Re: Makefile  issue)
Message-ID: <20030408164718.F18709@almesberger.net>
References: <OF51DE965A.FDCB6DBE-ON85256D01.005201B1-86256D01.005610CF@pok.ibm.com.suse. <p73vfxqxpz4.fsf@oldwotan.suse.de> <20030407232302.D19288@almesberger.net> <1049808651.30732.113.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049808651.30732.113.camel@plars>; from plars@linuxtestproject.org on Tue, Apr 08, 2003 at 08:30:50AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> I don't think so.  Apps should be accessing things through libraries
> anyway.  The only reason we don't in some cases like this is that it's
> new and not in libs on any distro yet.

Well yes, if the syscall is correctly implemented in the library,
there's no problem.

> Besides, I don't think having a
> /proc/syscalls would be any better than having to do ifdefs or use
> kernel headers.

#ifdef may be hard pressed to identify a specific kernel with a
specific patch. Kernel headers are obviously a solution (although
this violates the "user space must never include kernel headers"
pseudo-rule), but add the problem of needing to identify the
"current" source tree, which is a configuration step almost always
requiring manual intervention.

My suggestion for /proc/syscalls isn't entirely serious, but it 
would be nice if we could eventually solve this problem ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
