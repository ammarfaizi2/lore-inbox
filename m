Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVDEIAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVDEIAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDEH7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:59:33 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:28053 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261626AbVDEH4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:56:21 -0400
Date: Tue, 5 Apr 2005 01:57:41 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Esben Nielsen <simlo@phys.au.dk>
cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-Reply-To: <Pine.OSF.4.05.10504050106110.8387-100000@da410.phys.au.dk>
Message-ID: <Pine.LNX.4.61.0504050156420.2566@montezuma.fsmlabs.com>
References: <Pine.OSF.4.05.10504050106110.8387-100000@da410.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Esben Nielsen wrote:

> > I'm sure a lot of the yield() users could be converted to 
> > schedule_timeout(), some of the users i saw were for low memory conditions 
> > where we want other tasks to make progress and complete so that we a bit 
> > more free memory.
> > 
> 
> Easy, but damn ugly. Completions are the right answer. The memory system
> needs a queue system where tasks can sleep (with a timeout) until the
> right amount of memory is available instead of half busy-looping.

I agree entirely, that would definitely be a better way to go eventually.
