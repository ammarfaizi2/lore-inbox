Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUCKW6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUCKW6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:58:22 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:32764 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261802AbUCKW6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:58:17 -0500
Date: Thu, 11 Mar 2004 15:58:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][7/7] Move debugger_entry()
Message-ID: <20040311225816.GM5169@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <200403011538.44953.amitkale@emsyssoft.com> <40453023.6000004@mvista.com> <200403031115.44125.amitkale@emsyssoft.com> <4050D92B.7000802@mvista.com> <20040311222749.GK5169@smtp.west.cox.net> <4050ECEC.8050301@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4050ECEC.8050301@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 02:49:16PM -0800, George Anzinger wrote:

> Tom Rini wrote:
[snip]
> >For kgdboe, you need to wait for the ethernet driver, networking, etc.
> >Without going and trying to do some big special case, that's when it has
> >to be, for kgdboe.
> >
> >For serial, esp if you make kgdb_arch_init() handle kgdb_serial pointer,
> >it can happen much earlier.  In fact, in that case you could probably
> >throw breakpoint() in as first line of C (PPC32) or close to it (some
> >mappings needed i386, sh, others, generally speaking).
> 
> So the question is do we cater to the worst or the best?  If I put kgdb or 
> what ever on the command line, I would like to see the connection ASAP what 
> ever the connection is.  So possibly, the command line parse part of kgdb 
> sets a flag it it can not do the break NOW.  The late bloomer code finds 
> this flag when doing the kgdboe or what ever set up and enters at that 
> time.  Puts a little more smarts in the command line part, but gets things 
> rolling ASAP regardless of the interface.  This, of course, assumes that 
> the kgdboe or what ever has an independent way of getting entered as soon 
> as it can be set up, i.e. its prerequisites are satisfied.

This sound like what I passed along from dwmw2 a week ago I think. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
