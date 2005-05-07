Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVEGIqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVEGIqe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVEGInV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:43:21 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:38097 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262844AbVEGIl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:41:57 -0400
Date: Sat, 7 May 2005 14:10:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sharada@in.ibm.com, torvalds@osdl.org, paulus@samba.org, anton@samba.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, miltonm@bga.com
Subject: Re: [Fastboot] Re: [PATCH] ppc64: kexec support for ppc64
Message-ID: <20050507084044.GA6804@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <17019.3752.917407.742713@cargo.ozlabs.ibm.com> <20050506124158.GA2741@in.ibm.com> <20050506124409.GB2741@in.ibm.com> <20050506160546.388aeed4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506160546.388aeed4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Fri, May 06, 2005 at 04:05:46PM -0700, Andrew Morton wrote:
> 
> This kdump/kexec stuff has been hanging around for far too long, IMO.  I'd
> like to think about what we can do to get things moving along a bit more.
> 
> I have two issues with it:
> 
> a) Vague feelings that the low-level ia32 changes may cause APIC/etc
>    breakage with some PCs.
> 
> b) Much more significantly: I still do not believe that it has been
>    demonstrated that the whole kdump-via-kexec scheme will have a
>    sufficiently high success rate for this to become Linux's way of doing
>    crashdumps.

This is a chicken-and-egg problem. Unless we have kexec/kdump
in mainline with a lot of users, we may not find out all the 
corner cases.

>    And it would not be good if in six months time we decide that the
>    practical problems in getting it all working sufficiently well are
>    insurmountable and we have to revert it all and start working on
>    something else.
> 
>    So am I right to have this concern?  If so, how can we settle this? 
>    (ie: who's going to do it?  ;))
> 
> 
> Perhaps we could declare that kexec is sufficiently useful and mature in
> its own right and just merge up those bits while we work on kdump.  This
> also gives us a bit of pipelining: continue to test and stabilise kexec
> while kdump remains in development.
> 
> Opinions are sought...

FWIW, based on prior experience in other OS, I believe that kexec
based approach is the most flexible and safest for supporting such
a diverse set of platforms that linux supports. The issues however
are -

1. I don't think we can achieve kdump with very high reliability within
   the few months it has had so far. Again, if prior experience
   with similar mechanism is worth anything, it will take a long
   time to achieve very high reliability on dozens of chipsets, several
   cpus, dozens of different platforms and various combinations
   thereof not to mention many different situations when kdump
   is used.

2. The way I see it, beyond a certain amount reliability (common
   x86, x86_64, ppc64 platforms, normal kernel developer use), we
   will need exposure to a much larger user base (large customer
   deployments will be the most useful) to find and sort out the remaining
   corner cases.

I hope we have it available for a large user base in mainline
as soon as it is reliable enough for common platforms and
kernel developer use.

Thanks
Dipankar
