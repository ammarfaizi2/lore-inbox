Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbULIOoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbULIOoi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbULIOoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:44:38 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:62337 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261475AbULIOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:44:36 -0500
Message-ID: <38223.195.245.190.93.1102603395.squirrel@195.245.190.93>
In-Reply-To: <20041209131317.GA31573@elte.hu>
References: <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>
    <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>
    <1102526018.25841.308.camel@localhost.localdomain>
    <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
    <1102532625.25841.327.camel@localhost.localdomain>
    <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
    <1102543904.25841.356.camel@localhost.localdomain>
    <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu>
Date: Thu, 9 Dec 2004 14:43:15 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Mark Johnson" <mark_h_johnson@raytheon.com>,
       "K.R. Foley" <kr@cybsft.com>, "Florian Schmidt" <mista.tapas@gmx.net>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       emann@mrv.com, "Peter Zijlstra" <a.p.zijlstra@chello.nl>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 09 Dec 2004 14:44:34.0994 (UTC) FILETIME=[99CBA120:01C4DDFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>> SLAB draining was an oversight - it's mainly called when there is VM
>> pressure (which is not a stricly necessary feature, so i disabled it),
>> but i forgot about the module-unload case where it's a correctness
>> feature. Your patch is a good starting point, i'll try to fix it on
>> SMP too.
>
> here's the full patch against a recent tree, or download the -32-12
> patch from the usual place:
>
>     http://redhat.com/~mingo/realtime-preempt/
>
> Rui, Gene, does this fix the module unload crash you are seeing?
>

Tested with RT-V0.7.32-12 after some usb-storage plug/unplug bonanza. All
seems to be OK, at least on my laptop (P4/UP).

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

