Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUAUET2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266061AbUAUET2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:19:28 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:3506 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266058AbUAUETZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:19:25 -0500
Message-ID: <400DFC8B.7020906@cyberone.com.au>
Date: Wed, 21 Jan 2004 15:14:03 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Tim Hockin <thockin@hockin.org>, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
References: <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au> <20040120084352.GD15733@hockin.org> <20040121093633.A3169@in.ibm.com>
In-Reply-To: <20040121093633.A3169@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Srivatsa Vaddagiri wrote:

>On Tue, Jan 20, 2004 at 12:43:52AM -0800, Tim Hockin wrote:
>
>>IFF the app is designed to handle it.  The existence of a SIGPWR handler
>>does not necessarily imply that, though.  a SIGCPU or something might
>>correlate 1:1 with this, but SIGPWR doesn't.
>>
>
>I agree we should have a separe signal for CPU Hotplug. By default the signal 
>will be ignored, unless a task registers a signal handler for that special 
>signal.
>

I'd be happy with that.

>
>That way, tasks which "knowingly" change their CPU affinity will be able to 
>tackle a CPU going down by handling the signal (probably change their CPU 
>affinity again), while tasks which have their CPU affinity changed "unknowingly"
>(by other tasks) will just ignore the signal. The hotplug script interface
>allows the admin to go and change the CPU affinity again for the second class 
>of tasks, if needed.
>

Yes, that is with the cpu-is-down hotplug event, right?

*Before* that happens, tasks that don't handle the signal should just
have their affinity changed to all cpus.

Or doesn't anybody care to think about hoplug scripts failing?
(serious question)


