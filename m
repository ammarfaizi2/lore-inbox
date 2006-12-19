Return-Path: <linux-kernel-owner+w=401wt.eu-S932710AbWLSJEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWLSJEG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWLSJEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:04:06 -0500
Received: from poczta.o2.pl ([193.17.41.142]:34541 "EHLO poczta.o2.pl"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932702AbWLSJEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:04:04 -0500
Date: Tue, 19 Dec 2006 10:05:06 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
Message-ID: <20061219090506.GA2641@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
References: <20061216080458.GC16116@elte.hu> <20061219084359.GB1731@ff.dom.local> <20061219085103.GK21070@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219085103.GK21070@parisc-linux.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 01:51:03AM -0700, Matthew Wilcox wrote:
> On Tue, Dec 19, 2006 at 09:43:59AM +0100, Jarek Poplawski wrote:
> > I wonder why doing debug_locks_off depends here on
> > debug_lock_silent state which is only "esthetical"
> > flag. And debug_locks_off() takes into consideration
> > debug_lock_silent after all. So IMHO:
> 
> It's not 'aesthetic' at all.  It's used to say "We are about to cause a
> locking failure deliberately as part of the test suite".  It would be
> wrong to disable lock debugging as a result of running the test suite.

So it's probably something with my English...
>From lib/debug_locks.c:

"/*
 * The locking-testsuite uses <debug_locks_silent> to get a
 * 'silent failure': nothing is printed to the console when
 * a locking bug is detected.
 */
int debug_locks_silent;"

Jarek P.
