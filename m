Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUHBP4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUHBP4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUHBP4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:56:35 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:18413 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266568AbUHBP4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:56:34 -0400
Date: Mon, 2 Aug 2004 12:00:15 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: V Srivatsa <vatsa@in.ibm.com>, nathanl@in.ibm.com,
       Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       nickp@in.ibm.com
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
In-Reply-To: <20040802094907.GA3945@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0408021158040.4095@montezuma.fsmlabs.com>
References: <20040802094907.GA3945@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Dipankar Sarma wrote:

> Could it be that recent sched domain stuff broke CPU hotplug ?
> While testing cpu hotplug with some RCU changes, I got the following
> panic (while onlining).

This may be related, i bumped into similar backtrace on i386 when a timer
interrupt snuck in whilst the cpu was offline, so i ended up enabling
timer interrupts only after the processor was on the map. This setup
managed to survive 12hours with a kernel compile load over the weekend.
