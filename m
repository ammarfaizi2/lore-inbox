Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbUB0XvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbUB0XvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:51:13 -0500
Received: from gprs158-32.eurotel.cz ([160.218.158.32]:36736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263197AbUB0XvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:51:11 -0500
Date: Sat, 28 Feb 2004 00:50:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, amit@av.mvista.com,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Message-ID: <20040227235059.GG425@elf.ucw.cz>
References: <20040227212301.GC1052@smtp.west.cox.net> <403FC521.7040508@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403FC521.7040508@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >+config KGDB_THREAD
> >+	bool "KGDB: Thread analysis"
> >+	depends on KGDB
> >+	help
> >+	  With thread analysis enabled, gdb can talk to kgdb stub to list
> >+	  threads and to get stack trace for a thread. This option also 
> >enables
> >+	  some code which helps gdb get exact status of thread. Thread 
> >analysis
> >+	  adds some overhead to schedule and down functions. You can disable
> >+	  this option if you do not want to compromise on speed.
> 
> Lets remove the overhead and eliminate the need for this option in favor of 
> always having threads.  Works in the mm kgdb...

No. Thread analysis is unsuitable for the mainline (manipulates
sched.c in ugly way). It may be okay for -mm, but in such case it
should better be separated.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
