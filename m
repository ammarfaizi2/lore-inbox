Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270083AbTGNOnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270057AbTGNOnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:43:12 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:63190 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S270631AbTGNOjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:39:51 -0400
Date: Mon, 14 Jul 2003 16:54:29 +0200
To: Dave Jones <davej@codemonkey.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030714145429.GD20708@h55p111.delphi.afb.lu.se>
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se> <20030714135948.GA27930@suse.de> <20030714142152.GC20708@h55p111.delphi.afb.lu.se> <20030714142838.GA29413@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714142838.GA29413@suse.de>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19c4ij-0007e0-00*gvr3Mm786vs*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 03:28:38PM +0100, Dave Jones wrote:
>  > The real patch contains cleaned up HZ-ifdefs.
> 
> good good..

Testing it an extra time now.

>  > Or as Christoph answered: "Oh well, stupid crappy hardware..."
> 
> That's a possibility, but if that were the case, I'd expect other things
> also to start randomly failing. It's unclear to me how -O2 would make
> a hardware bug more aparent. If it did so, that would also mean you'd
> have to ensure all your userspace was similarly compiled, which sounds
> very suspect.  It's just a celeron based PC with nvidia nforce chipset right ?
> If that combination caused such problems, I'd expect to see the
> occasional problem report from non-Xbox regular home-built PC users too.

It only happens when paging is off. Hence no problem as soon as the kernel
is up and running. -O2 changes the memory-access patterns so it is quite
possible that it would expose hardware bugs.

> Might be one worth picking over on the gcc lists if you can identify
> which part gets miscompiled ?
> 
> Tried different versions of binutils too ?

On 1.0 xboxes it works with any gcc with or without optimizations on.

On 1.1+ xboxen it does NOT work with 2.95, -O0 or -O2. But with 3.2.2-3.3 it
is known to work with -O0.

It's was not easy to localize the crashes. Cos adding more code for
debugging moves the point where it crashes around. However it does crash
reading from memory. A prefectly valid address. That it just a few
instructions earlier had written and read from.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
