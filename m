Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWBHK0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWBHK0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 05:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWBHK0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 05:26:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46812 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932116AbWBHK0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 05:26:36 -0500
Date: Wed, 8 Feb 2006 11:25:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: preempt-rt, NUMA and strange latency traces
Message-ID: <20060208102500.GA10942@elte.hu>
References: <1139311689.19708.36.camel@frecb000686> <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> >   I've been experimenting with 2.6.15-rt16 on a dual 2.8GHz Xeon box
> > with quite good results and decided to make a run on a NUMA dual node
> > IBM x440 (8 1.4GHz Xeon, 28GB ram).
> >
> >   However, the kernel crashes early when creating the slabs. Does the
> > current preempt-rt patchset supports NUMA machines or has support
> > been disabled until things settle down?
> 
> Yeah, currently the -rt patch doesn't work well with NUMA.

FYI, i've got a new port of upstream slab.c to -rt, which should work on 
NUMA too. It'll be in -rt17 (later today or tomorrow).

	Ingo
