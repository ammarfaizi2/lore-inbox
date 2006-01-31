Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWAaSLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWAaSLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWAaSLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:11:00 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:27055 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751306AbWAaSK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:10:59 -0500
Subject: Re: CONFIG_PREEMPT_SOFTIRQS
From: Steven Rostedt <rostedt@goodmis.org>
To: Vinod KK <kkvinod@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c2f233c10601310649j6b104787m5a2287d3e022a911@mail.gmail.com>
References: <c2f233c10601310649j6b104787m5a2287d3e022a911@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 13:10:55 -0500
Message-Id: <1138731055.7088.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 20:19 +0530, Vinod KK wrote:
> Hi,
> 
> I am using linux 2.6.10 (with Ingo Molnars real time patches) on my mips board.
> 
> When I try running high network traffic (10% traffic on a 100Mbps
> link) on my target board with the CONFIG_PREEMPT_DESKTOP=y and
> CONFIG_PREEMPT_SOFTIRQS=y options enabled I notice that the console
> freezes and recovers only after the traffic stops. I do not notice
> this behaviour with the CONFIG_PREEMPT_SOFTIRQS option disabled.
> 
> I understand that the CONFIG_PREEMPT_SOFTIRQS option puts all softirq
> processing to the ksoftirqd daemon, but i do not see why this should
> stall the console. I believe there should be some task which is
> starving for CPU, but I do not know which one.
> 
> The console is on an 16550 serial port.
> 
> Could someone please give me some pointers on where I should start looking?

2.6.10 with Ingo's patch is pretty old.  The -rt patch is very much a
moving target today and is not yet stable.  So the only real answer I
can give you is to go ahead and download
http://people.redhat.com/mingo/realtime-preempt/patch-2.6.15-rt16
and try that out.

-- Steve


