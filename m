Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVBOR2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVBOR2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVBOR2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:28:37 -0500
Received: from orb.pobox.com ([207.8.226.5]:10929 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261473AbVBOR0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:26:40 -0500
Date: Tue, 15 Feb 2005 11:26:34 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6-bk: cpu hotplug + preempt = smp_processor_id warnings galore
Message-ID: <20050215172634.GB22304@otto>
References: <20050211232821.GA14499@otto> <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com> <20050214215948.GA22304@otto> <Pine.LNX.4.61.0502150828520.26742@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502150828520.26742@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 08:29:33AM -0700, Zwane Mwaikambo wrote:
> On Mon, 14 Feb 2005, Nathan Lynch wrote:
> 
> > It looks as if we need to explicitly bind worker threads to a newly
> > onlined cpu.  This gets rid of the smp_processor_id warnings from
> > cache_reap.  Adding a little more instrumentation to the debug
> > smp_processor_id showed that new worker threads were actually running
> > on the wrong cpu...
> > 
> > Does this look ok?
> 
> Yeah, does that patch suffice for all the warnings?

Nope, ksoftirqd still requires your patch in order to kill the
warnings there.

Nathan
