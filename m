Return-Path: <linux-kernel-owner+willy=40w.ods.org-S291561AbUKBARf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S291561AbUKBARf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291564AbUKBARf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:17:35 -0500
Received: from fsmlabs.com ([168.103.115.128]:43653 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S385249AbUKBARQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:17:16 -0500
Date: Mon, 1 Nov 2004 17:16:02 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Lee Revell <rlrevell@joe-job.com>
cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
In-Reply-To: <1099332277.3647.43.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0411011711560.2985@musoma.fsmlabs.com>
References: <20041101084337.GA7824@dominikbrodowski.de> 
 <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
 <1099332277.3647.43.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Lee Revell wrote:

> On Mon, 2004-11-01 at 07:00 -0700, Zwane Mwaikambo wrote:
> > Agreed it makes a lot more sense, i think there could be some places where 
> > we use preempt_disable to protect against cpu offline which could 
> > converted, but that can come later.
> > 
> 
> You know I picked up Robert Love's book the other day and was surprised
> to read we are not supposed to be using preempt_disable, there is a
> per_cpu interface for exactly this kind of thing.  Which is currently
> recommended?

It's on a case by case basis, preempt_disable has the side effect of 
ensuring that you run through that specific critical section without being 
interrupted by scheduling, this happens to also block out various things 
like RCU and the stop_machine (used by cpu hotplug) code amongst others. 
I'm curious what is the excert that you're referring to?

Thanks,
	Zwane

