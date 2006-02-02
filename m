Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWBBBKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWBBBKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWBBBKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:10:23 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:55472 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161030AbWBBBKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:10:22 -0500
Subject: Re: 2.6.15-rt16
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Cc: chris perkins <cperkins@OCF.Berkeley.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <1138833380.18762.67.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
	 <1138830476.6632.5.camel@localhost.localdomain>
	 <1138830694.18762.46.camel@localhost.localdomain>
	 <1138832179.6632.12.camel@localhost.localdomain>
	 <1138833380.18762.67.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 20:10:12 -0500
Message-Id: <1138842612.6632.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 16:36 -0600, Clark Williams wrote:
> On Wed, 2006-02-01 at 17:16 -0500, Steven Rostedt wrote:
> > 
> > No, but I don't use an initrd, so my failure was first that it couldn't
> > recognize my harddrives.  So I compiled in the necessary drivers into my
> > kernel, and it booted right up to the GDM login.  I logged in, and was
> > going to reply to you, but I guess I have a different network card since
> > I had no network.
> > 
> 
> Ok, I took the config file I sent you, globally substituted '=y' for
> '=m' and rebuilt, then booted that kernel. Other than a message that it
> was unable to open the console (udev wasn't started) I got the exact
> same failure (same panic backtrace).

Thanks for the clarification.

> 
> > > 
> > > I'm fairly certain that the initrd contains the appropriate modules,
> > > since I regenerate the initrd each time I generate a new kernel, but
> > > I'll go back and verify. 
> > > 
> > > I'll also convert modules to compiled in and see if that makes a
> > > difference.
> > 
> > Thanks, I've been burnt before with incompatible modules in initrd, that
> > I now only use compiled in modules that are needed to boot (ide, ext3,
> > etc).  When compiling 3 different kernels with several different configs
> > constantly for the same machine, it just becomes easier to not use an
> > initrd.
> 
> One of the things I wanted to see was how the -rt patch worked with
> SELinux, so I decided to try and run a kernel that looked like a distro
> kernel (in this case FC4).  I just put together some scripting logic to
> build the kernel and module tree three times (athlon64, p3smp, and
> duron).  After I've rebuilt, I install on each target system using a
> shell script that deletes the old module tree, rsyncs a new one,
> installs the matching kernel and builds a new initrd.
> 
> Hmmm, FC4 is based on 2.6.14.x. Did something change in the 2.6.15
> series that needs a user-space change as well? (I'm running a current
> FC4 rootfs).

But, didn't you say that if you turn off LATENCY_TRACING that the -rt
patched kernel boots?

So, now it seems to be something hardware specific that is different
between your machine and mine.

Note:  I'm using Debian.

-- Steve


