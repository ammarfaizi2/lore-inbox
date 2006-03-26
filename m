Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWCZEyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWCZEyM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 23:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWCZEyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 23:54:11 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:6580
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932081AbWCZEyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 23:54:11 -0500
Date: Sat, 25 Mar 2006 20:54:04 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [patch 00/10] PI-futex: -V1
Message-ID: <20060326045404.GA9308@gnuppy.monkey.org>
References: <20060325184528.GA16724@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325184528.GA16724@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 07:45:28PM +0100, Ingo Molnar wrote:
> We are pleased to announce "lightweight userspace priority inheritance" 
> (PI) support for futexes. The following patchset and glibc patch 
> implements it, ontop of the robust-futexes patchset which is included in 
> 2.6.16-mm1.
... 
> Priority Inheritance - why, oh why???
> -------------------------------------
...
> The longer reply:
> -----------------

[comments on app usages of priority inheritance deleted]

You'll need to do priority ceiling emulation as well. I've been using that in an
application as a manual means of preventing preemption of key critical sections,
like a spinlock/preempt_disable(), to prevent priority inversion from happening.
Raising the priority of threads using that lock/critical section is a pretty
effective means of partitioning program logical sections of the application into
threads that are higher and lower priority than the resource. It's cool stuff.

bill

