Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422964AbWAMVFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422964AbWAMVFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422967AbWAMVFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:05:36 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:23545 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422964AbWAMVFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:05:35 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: Lee Revell <rlrevell@joe-job.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       Roger Heflin <rheflin@atipa.com>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <1137185175.7634.37.camel@localhost.localdomain>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
	 <1137183980.6731.1.camel@localhost.localdomain>
	 <1137184982.15108.69.camel@mindpipe>
	 <1137185175.7634.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 16:05:19 -0500
Message-Id: <1137186319.6731.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 21:46 +0100, Thomas Gleixner wrote:
> On Fri, 2006-01-13 at 15:43 -0500, Lee Revell wrote:
> 
> > Ugh.  In arch/x86_64/kernel/time.c monotonic_clock() uses the TSC
> > unconditionally.
> 
> Can you try 
> 
> http://tglx.de/projects/hrtimers/2.6.15/patch-2.6.15-hrt2.patch
> 
> please ?
> 
> 	tglx
> 
> 

Hmm, it doesn't compile :(

-- Steve

rostedt@gandalf:~/work/kernels/linux-2.6.15-hrt2$ make
amdmake
  CHK     include/linux/version.h
  CC      arch/x86_64/kernel/asm-offsets.s
In file included from include/linux/timex.h:61,
                 from include/linux/sched.h:11,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/timex.h: In function 'get_cycles_sync':
include/asm/timex.h:36: warning: implicit declaration of function 'alternative_io'
include/asm/timex.h:37: error: called object '"=a"' is not a function
include/asm/timex.h:37: error: called object '"0"' is not a function
include/asm/timex.h:37: error: syntax error before ':' token
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2



