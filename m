Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbTCGH7b>; Fri, 7 Mar 2003 02:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbTCGH7b>; Fri, 7 Mar 2003 02:59:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:16774 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261425AbTCGH7a>;
	Fri, 7 Mar 2003 02:59:30 -0500
Date: Fri, 7 Mar 2003 00:10:02 -0800
From: Andrew Morton <akpm@digeo.com>
To: Mike Galbraith <efault@gmx.de>
Cc: mingo@elte.hu, torvalds@transmeta.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-Id: <20030307001002.74b8662b.akpm@digeo.com>
In-Reply-To: <5.2.0.9.2.20030307085949.00ce8008@pop.gmx.net>
References: <5.2.0.9.2.20030307075851.00cf5448@pop.gmx.net>
	<5.2.0.9.2.20030307085949.00ce8008@pop.gmx.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 08:09:58.0455 (UTC) FILETIME=[F1DD3C70:01C2E480]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> ...
> Best would be for other testers to run some tests.  With the make -j30 
> weirdness, I _suspect_ that other oddities (hmm... multi-client db load... 
> query service time) will show.
> 

Yes, this is the second surprise interaction between the CPU scheduler
and the IO system.

Perhaps.  In your case it seems that you're simply unable to generate
the amount of concurrency which you used to.  Which would make it purely
a CPU scheduler thing.

It is not necessarily a bad thing (unless your total runtime has increased?)
but we need to understand what has happened.

What filesystem are you using?
