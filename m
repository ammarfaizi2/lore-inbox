Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263223AbUB1BI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbUB1BI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:08:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25582 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263223AbUB1BIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:08:24 -0500
Message-ID: <403FEA02.6040506@mvista.com>
Date: Fri, 27 Feb 2004 17:08:18 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, amit@av.mvista.com,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
References: <20040227212301.GC1052@smtp.west.cox.net> <403FC521.7040508@mvista.com> <20040227235059.GG425@elf.ucw.cz>
In-Reply-To: <20040227235059.GG425@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
> 
>>>+config KGDB_THREAD
>>>+	bool "KGDB: Thread analysis"
>>>+	depends on KGDB
>>>+	help
>>>+	  With thread analysis enabled, gdb can talk to kgdb stub to list
>>>+	  threads and to get stack trace for a thread. This option also 
>>>enables
>>>+	  some code which helps gdb get exact status of thread. Thread 
>>>analysis
>>>+	  adds some overhead to schedule and down functions. You can disable
>>>+	  this option if you do not want to compromise on speed.
>>
>>Lets remove the overhead and eliminate the need for this option in favor of 
>>always having threads.  Works in the mm kgdb...
> 
> 
> No. Thread analysis is unsuitable for the mainline (manipulates
> sched.c in ugly way). It may be okay for -mm, but in such case it
> should better be separated.

Not in the -mm version.  I agree that sched.c should NEVER be treated this way 
and it is not in the -mm version.  I also think that, most of the time, it is 
useful to have the thread stuff, but that may be just my usage...


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

