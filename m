Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293236AbSCJVDZ>; Sun, 10 Mar 2002 16:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293237AbSCJVDP>; Sun, 10 Mar 2002 16:03:15 -0500
Received: from ns.suse.de ([213.95.15.193]:29959 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293236AbSCJVDF>;
	Sun, 10 Mar 2002 16:03:05 -0500
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
In-Reply-To: <1015784104.1261.8.camel@phantasy> <u8zo1g9nf8.fsf@gromit.moeb>
	<1015793618.928.17.camel@phantasy>
From: Andreas Jaeger <aj@suse.de>
Date: Sun, 10 Mar 2002 22:03:02 +0100
In-Reply-To: <1015793618.928.17.camel@phantasy> (Robert Love's message of
 "10 Mar 2002 15:53:38 -0500")
Message-ID: <u8bsdw9lvd.fsf@gromit.moeb>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> writes:

> On Sun, 2002-03-10 at 15:29, Andreas Jaeger wrote:
>  
>> Please add the procinterface also!  I've found it today (for 2.4.18)
>> and it's much easier to use with existing programs.
>
> I agree and I really like the proc-interface.  There is something uber
> cool about:
>
> 	cat 1 > /proc/pid/affinity

I agree.

> I have a patch for 2.5.6 for proc-based affinity interface here:
>
> 	http://www.kernel.org/pub/linux/kernel/people/rml/cpu-affinity/v2.5/cpu-affinity-proc-rml-2.5.6-1.patch
>
> I suspect, however, that despite both patches being small we really only
> want to pick and standardize on one.  The syscall interface has two main
> things going for it against a proc-based implementation: it is faster
> and /proc may not be mounted.  The masses have spoken on this issue.
>
> Note you can use the syscall interface with existing programs, too. 
> Just write a program to take in a pid and mask and call
> sched_set_affinity.

What I need at the moment is a wrapper - and you can do it two ways:

$ run_with_affinity 1 program arguments...
$ (cat 1 > /proc/self/affinity; program arguments...)

The second one is much easier coded ;-)

>> Please add it for all archs - this is not only interesting for x86,
>
> I'll send Linus the patch for other arches if/when he accepts this patch
> - I have no problem with that.

Thanks,
Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
