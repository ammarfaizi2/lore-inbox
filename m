Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267533AbTGOMla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267590AbTGOMla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:41:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41836 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S267533AbTGOM1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:27:45 -0400
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se>
	<20030714135948.GA27930@suse.de>
	<20030714142152.GC20708@h55p111.delphi.afb.lu.se>
	<20030714142838.GA29413@suse.de>
	<20030714145429.GD20708@h55p111.delphi.afb.lu.se>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jul 2003 06:39:46 -0600
In-Reply-To: <20030714145429.GD20708@h55p111.delphi.afb.lu.se>
Message-ID: <m1ptkcx8tp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Gustafsson <andersg@0x63.nu> writes:

> On Mon, Jul 14, 2003 at 03:28:38PM +0100, Dave Jones wrote:
> >  > The real patch contains cleaned up HZ-ifdefs.
> > 
> > good good..
> 
> Testing it an extra time now.
> 
> >  > Or as Christoph answered: "Oh well, stupid crappy hardware..."
> > 
> > That's a possibility, but if that were the case, I'd expect other things
> > also to start randomly failing. It's unclear to me how -O2 would make
> > a hardware bug more aparent. If it did so, that would also mean you'd
> > have to ensure all your userspace was similarly compiled, which sounds
> > very suspect.  It's just a celeron based PC with nvidia nforce chipset right ?
> 
> > If that combination caused such problems, I'd expect to see the
> > occasional problem report from non-Xbox regular home-built PC users too.
> 
> It only happens when paging is off. Hence no problem as soon as the kernel
> is up and running. -O2 changes the memory-access patterns so it is quite
> possible that it would expose hardware bugs.
>
> 
> > Might be one worth picking over on the gcc lists if you can identify
> > which part gets miscompiled ?
> > 
> > Tried different versions of binutils too ?
> 
> On 1.0 xboxes it works with any gcc with or without optimizations on.
> 
> On 1.1+ xboxen it does NOT work with 2.95, -O0 or -O2. But with 3.2.2-3.3 it
> is known to work with -O0.
> 
> It's was not easy to localize the crashes. Cos adding more code for
> debugging moves the point where it crashes around. However it does crash
> reading from memory. A prefectly valid address. That it just a few
> instructions earlier had written and read from.

Have you tried running memtest86 on the box?  Except when you have more
than 2GB memtest86 does not enable paging, so another code sequence can
reproduce this bug memtest86 is likely to do it.

Eric
