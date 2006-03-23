Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbWCWS0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWCWS0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWCWS0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:26:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932674AbWCWS0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:26:49 -0500
Date: Thu, 23 Mar 2006 13:26:16 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       iwamoto@valinux.co.jp, christoph@lameter.com, wfg@mail.ustc.edu.cn,
       npiggin@suse.de
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
In-Reply-To: <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
Message-ID: <Pine.LNX.4.63.0603231318100.23558@cuia.boston.redhat.com>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
 <20060322145132.0886f742.akpm@osdl.org> <20060323205324.GA11676@dmt.cnet>
 <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006, Linus Torvalds wrote:

>  a) the current one actually seems to have beaten the on-comers (except 
>     for loads that were actually made up to try to defeat LRU)

A valid concern.  I am of the opinion that we should try to
introduce change in small increments, whereever possible.

>  b) is page replacement actually a huge issue?

Being involved in RHEL support occasionally:  YES!

Page replacement may be doing the right thing in 99% of the
cases, but the misbehaviour in "corner cases" can be very
significant.  I put "corner cases" in quotes because they
are not cornercases to the users - these loads tend to be
the main workload on some systems!

IMHO, improving performance for most workloads is nowhere 
near as important as increasing the coverage of the VM,
ie. the number of workloads that it handles well.


-- 
All Rights Reversed
