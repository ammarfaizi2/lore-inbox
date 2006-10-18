Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422772AbWJRSsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422772AbWJRSsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWJRSsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:48:22 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12438 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422772AbWJRSsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:48:21 -0400
Date: Wed, 18 Oct 2006 11:48:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
In-Reply-To: <45366DF0.6040702@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610181145250.29163@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com>
 <4536629C.4050807@yahoo.com.au> <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com>
 <45366DF0.6040702@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006, Nick Piggin wrote:

> wake_priority_sleeper should not be called from rebalance_tick. That
> code was OK where it was before, I think.

wake_priority_sleeper() is necessary to establish the idle state.

> And you need to now turn off interrupts when doing the locking in
> load_balance.

Hmmm.. yes requires to review all the locks. sigh.

