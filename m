Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUB0XIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbUB0XIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:08:50 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:52453 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S263202AbUB0XIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:08:41 -0500
Date: Fri, 27 Feb 2004 16:08:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][7/7] Move debugger_entry()
Message-ID: <20040227230838.GM1052@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net> <20040227213254.GE1052@smtp.west.cox.net> <20040227214031.GF1052@smtp.west.cox.net> <20040227214605.GH1052@smtp.west.cox.net> <20040227215211.GI1052@smtp.west.cox.net> <20040227215428.GJ1052@smtp.west.cox.net> <403FCA7D.5040607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403FCA7D.5040607@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 02:53:49PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >Hello.  When we use kgdboe, we can't use it until do_basic_setup() is done.
> >So we have two options, not allow kgdboe to use the initial breakpoint
> >or move debugger_entry() to be past the point where kgdboe will be usable.
> >I've opted for the latter, as if an earlier breakpoint is needed you can
> >still use serial and throw kgdb_schedule_breakpoint/breakpoint where 
> >desired.
> 
> Please don't do this.  How about configuring it along with the connection 
> method.  I really don't want to have to modify the kernel just to get in 
> early.

This is 'early'.  Keep in mind that this version of KGDB already isn't
breaking in nearly as early as the one in -mm (this version is currently
doing it just before do_basic_setup()).  And keep in mind that the goal
of this version right now is to get something clean and small that can
somehow slip into Linus' tree.  Changes to the non-lite
core/i386/whatever to allow for much earlier access is fine.

-- 
Tom Rini
http://gate.crashing.org/~trini/
