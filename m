Return-Path: <linux-kernel-owner+w=401wt.eu-S964810AbXALRnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbXALRnU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXALRnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:43:20 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:50176 "EHLO
	tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932355AbXALRnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:43:19 -0500
Date: Fri, 12 Jan 2007 12:43:12 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 05/05] Linux Kernel Markers, non optimised architectures
Message-ID: <20070112174312.GA22771@Krystal>
References: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca> <11685601404005-git-send-email-mathieu.desnoyers@polymtl.ca> <45A710F8.7000405@yahoo.com.au> <20070112050032.GA14100@Krystal> <45A71827.6020300@yahoo.com.au> <20070112171512.GB2888@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20070112171512.GB2888@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:39:57 up 142 days, 14:47,  4 users,  load average: 0.50, 0.48, 0.45
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca) wrote:
> > 
> > OK, well one problem is that it can cause a resched event to be lost, so
> > you might say it has more side-effects without checking resched.
> > 
[...]
> If we are sure that we expect calls to preempt_schedule() from each of these
> contexts, then it's ok to put preempt_enable(). It is important to note that a
> marker would then act as a source of scheduler events in code paths where
> disabling interrupts is expected to disable the scheduler.
> 

Sorry for self-reply, but the above mentioned issue is dealt by the
irqs_disabled() check at the beginning of preempt_schedule().

Mathieu


-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
