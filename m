Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUCHKtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 05:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUCHKtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 05:49:32 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:61929 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262455AbUCHKta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 05:49:30 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Mon, 8 Mar 2004 16:19:16 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081545.09916.amitkale@emsyssoft.com> <20040308022602.766be828.akpm@osdl.org>
In-Reply-To: <20040308022602.766be828.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081619.16771.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > Here are features that are present only in full kgdb:
> >  1. Thread support  (aka info threads)
>
> argh, disaster.  I discussed this with Tom a week or so ago when it looked
> like this it was being chopped out and I recall being told that the
> discussion was referring to something else.
>
> Ho-hum, sorry.  Can we please put this back in?

Err., well this is one of the particularly dirty parts of kgdb. That's why 
it's been kept away. It takes care of correct thread backtraces in some rare 
cases.

If you consider it an absolutely must, we can do something so that the dirty 
part is kept away and info threads almost always works.

>
> >  2. console messages through gdb
>
> hm, it was occasionally handy.  Is there a lot of code involved?

Nope. Code is already in, it's just a matter of adding a config option.

>
> >  3. Automatic loading of modules in gdb
>
> OK.  I think.  What does this feature actually do?

This feature lets gdb hook onto a kernel function to detect loading and 
unloading of modules and preserves module section information for later use 
by gdb. At present this is broken for 2.6 kernels. I am working on this.

>
> >  4. Support for x86_64
> >  5. Support for powerpc
>
> These are planned, I assume?

Yes. As soon as i386 goes in. x86_64 is already very clean. There was another 
opinion about whether x86_64 should be the first one to go in!

ppc might need some work.

> >  6. kgdb over ethernet [This isn't ready in the full version as well at
> > this point of time]
>
> OK.  But the version in -mm and -mpm works OK, does it not?  Is there some
> difference in implementation which causes it to be broken in your tree?

There are some differences. The one in my tree also apparently works to some 
extent. It's being worked on.

-Amit

