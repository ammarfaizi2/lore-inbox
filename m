Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVBOP2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVBOP2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVBOP2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:28:53 -0500
Received: from fsmlabs.com ([168.103.115.128]:44766 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261752AbVBOP2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:28:51 -0500
Date: Tue, 15 Feb 2005 08:29:33 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nathan Lynch <ntl@pobox.com>
cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6-bk: cpu hotplug + preempt = smp_processor_id warnings galore
In-Reply-To: <20050214215948.GA22304@otto>
Message-ID: <Pine.LNX.4.61.0502150828520.26742@montezuma.fsmlabs.com>
References: <20050211232821.GA14499@otto> <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com>
 <20050214215948.GA22304@otto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2005, Nathan Lynch wrote:

> It looks as if we need to explicitly bind worker threads to a newly
> onlined cpu.  This gets rid of the smp_processor_id warnings from
> cache_reap.  Adding a little more instrumentation to the debug
> smp_processor_id showed that new worker threads were actually running
> on the wrong cpu...
> 
> Does this look ok?

Yeah, does that patch suffice for all the warnings?
