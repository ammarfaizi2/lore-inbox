Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUCAJYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUCAJYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:24:55 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:43983 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261194AbUCAJYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:24:53 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Date: Mon, 1 Mar 2004 14:54:35 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227235059.GG425@elf.ucw.cz> <403FEA02.6040506@mvista.com>
In-Reply-To: <403FEA02.6040506@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011454.35346.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 Feb 2004 6:38 am, George Anzinger wrote:
> Pavel Machek wrote:
> > Hi!
> >
> >>>+config KGDB_THREAD
> >>>+	bool "KGDB: Thread analysis"
> >>>+	depends on KGDB
> >>>+	help
> >>>+	  With thread analysis enabled, gdb can talk to kgdb stub to list
> >>>+	  threads and to get stack trace for a thread. This option also
> >>>enables
> >>>+	  some code which helps gdb get exact status of thread. Thread
> >>>analysis
> >>>+	  adds some overhead to schedule and down functions. You can disable
> >>>+	  this option if you do not want to compromise on speed.
> >>
> >>Lets remove the overhead and eliminate the need for this option in favor
> >> of always having threads.  Works in the mm kgdb...
> >
> > No. Thread analysis is unsuitable for the mainline (manipulates
> > sched.c in ugly way). It may be okay for -mm, but in such case it
> > should better be separated.
>
> Not in the -mm version.  I agree that sched.c should NEVER be treated this
> way and it is not in the -mm version.  I also think that, most of the time,
> it is useful to have the thread stuff, but that may be just my usage...

If threads stuff didn't introduce any unclean code changes, I too would prefer 
to have it on all the time. As things stands, threads stuff is rather 
intrusive.

-Amit

