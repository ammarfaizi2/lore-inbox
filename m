Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316964AbSGCH7r>; Wed, 3 Jul 2002 03:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSGCH7q>; Wed, 3 Jul 2002 03:59:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57011 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316964AbSGCH7p>;
	Wed, 3 Jul 2002 03:59:45 -0400
Date: Wed, 3 Jul 2002 09:59:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Nicholas Miell <nmiell@attbi.com>
Cc: Andreas Jaeger <aj@suse.de>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] batch/idle priority scheduling, SCHED_BATCH
In-Reply-To: <1025568143.1673.4.camel@entropy>
Message-ID: <Pine.LNX.4.44.0207030957500.2949-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Jul 2002, Nicholas Miell wrote:

> > > This can be done in glibc.  linux/sched.h should not be used by
> > > userspace applications, glibc has the define in <bits/sched.h> which is
> > > included from <sched.h> - and <sched.h> is the file defined by Posix.
> > 
> > yes, this was my thinking too.
> 
> OK, I can understand that line of reasoning.
> 
> Keep in mind that someday, someone who is looking for the implementation
> of the SCHED_OTHER policy will be thoroughly confused by the kernel's
> complete lack of reference to SCHED_OTHER. And they'll be asking you for
> clarification.
> 
> Or, you could make some note in the source that SCHED_OTHER is
> SCHED_NORMAL and eliminate any source of confusion now.

okay, i did this.

and, to not confuse existing code that still happens to use the kernel
headers, i added the #define to the 2.4.19-pre10-ac2 backport of the O(1)
scheduler.

	Ingo

