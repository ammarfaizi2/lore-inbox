Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVJJVMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVJJVMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVJJVMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:12:20 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:12279 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751244AbVJJVMT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:12:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gjJmG57tfJUEnnQJ6bZuv+ET/42AVn8xfzWx26hwCsCPeoSNCLCMJSvDLQm7Kn4EPqjlqgkT3nQSXGpD0WAPe1N1fxHpiufRvMrZvcwH1lEuyChicylLIJLgGFlsu3NWkM9BawEbwkKnUCbc0xRdA7JJKXPFY4qgODSjDqvGcL8=
Message-ID: <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
Date: Mon, 10 Oct 2005 14:12:18 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Daniel Walker <dwalker@mvista.com> wrote:
> On Mon, 2005-10-10 at 13:16 -0700, Mark Knecht wrote:
> > Hi,
>
> >
> > How can I get data that would be more useful in terms of real debug?
>
> The IRQ off times look like the worst . If you do "make menuconfig"
>
> then goto Kernel Hacking and select
> "Interrupts-off critical section latency timing"
> Then select "Latency tracing"
>
> Then when you boot the system before run the following,
>
> "echo 0 > /proc/sys/kernel/preempt_max_latency"

So this disables the tracing of preempt times but keeps IRQ times on? Cool.
>
>
> That will record a trace for every maximum latency observed for IRQ
> latency . You can view the trace with this command
> "cat /proc/latency_trace" , and you can attach the trace to an email to
> LKML so we can review it (compress it if it's big though) .
>
> Daniel

Will do. Building now. I'll be back later.

Is there anything specific I should look for in the traces myself?
Anyway to help narrow it down?

Cheers,
Mark
