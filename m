Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSGBAAB>; Mon, 1 Jul 2002 20:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSGBAAA>; Mon, 1 Jul 2002 20:00:00 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:48853 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S316588AbSGBAAA>; Mon, 1 Jul 2002 20:00:00 -0400
Subject: Re: [announce] [patch] batch/idle priority scheduling, SCHED_BATCH
From: Nicholas Miell <nmiell@attbi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andreas Jaeger <aj@suse.de>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0207010954420.2321-100000@e2>
References: <Pine.LNX.4.44.0207010954420.2321-100000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Jul 2002 17:02:21 -0700
Message-Id: <1025568143.1673.4.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-01 at 01:00, Ingo Molnar wrote:
> 
> On Mon, 1 Jul 2002, Andreas Jaeger wrote:
> > This can be done in glibc.  linux/sched.h should not be used by
> > userspace applications, glibc has the define in <bits/sched.h> which is
> > included from <sched.h> - and <sched.h> is the file defined by Posix.
> 
> yes, this was my thinking too.

OK, I can understand that line of reasoning.

Keep in mind that someday, someone who is looking for the implementation
of the SCHED_OTHER policy will be thoroughly confused by the kernel's
complete lack of reference to SCHED_OTHER. And they'll be asking you for
clarification.

Or, you could make some note in the source that SCHED_OTHER is
SCHED_NORMAL and eliminate any source of confusion now.

- Nicholas

