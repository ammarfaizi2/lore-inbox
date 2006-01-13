Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161503AbWAMKWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161503AbWAMKWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161538AbWAMKWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:22:04 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:2716
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1161503AbWAMKWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:22:03 -0500
Date: Fri, 13 Jan 2006 02:19:32 -0800
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
Message-ID: <20060113101932.GA23000@gnuppy.monkey.org>
References: <20060113080734.GA22091@gnuppy.monkey.org> <Pine.LNX.4.44L0.0601130937540.9269-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601130937540.9269-100000@lifa01.phys.au.dk>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 09:47:39AM +0100, Esben Nielsen wrote:
> On Fri, 13 Jan 2006, Bill Huey wrote:
> 
> > On Thu, Jan 12, 2006 at 01:54:23PM +0100, Esben Nielsen wrote:
> > > turnstiles? What is that?
> >
> > http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/kern/subr_turnstile.c
> >
> > Please, read. Now tell me or not if that looks familiar ? :)
> 
> Yes, it reminds me of Ingo's first approach to pi locking:
> Everything is done under a global spin lock. In Ingo's approach it was the
> pi_lock. In turnstiles it is sched_lock, which (without looking at other
> code in FreeBSD) locks the whole scheduler.
> 
> Although making the code a lot simpler, scalability is ofcourse the main
> issue here. But apparently FreeBSD does have a global lock protecting the
> scheduler anyway.

FreeBSD hasn't really address their scalability issues yet with their
locking. The valuable thing about that file is how they manipulate
threading priorities under priority inheritance. Some ideas might be
stealable from it. That's all.

bill

