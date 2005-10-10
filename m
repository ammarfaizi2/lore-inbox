Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVJJUtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVJJUtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVJJUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 16:49:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42991 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751223AbVJJUtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 16:49:21 -0400
Subject: Re: Latency data - 2.6.14-rc3-rt13
From: Daniel Walker <dwalker@mvista.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 13:49:18 -0700
Message-Id: <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 13:16 -0700, Mark Knecht wrote:
> Hi,

> 
> How can I get data that would be more useful in terms of real debug?

The IRQ off times look like the worst . If you do "make menuconfig"

then goto Kernel Hacking and select 
"Interrupts-off critical section latency timing"
Then select "Latency tracing"

Then when you boot the system before run the following,

"echo 0 > /proc/sys/kernel/preempt_max_latency"

 
That will record a trace for every maximum latency observed for IRQ
latency . You can view the trace with this command
"cat /proc/latency_trace" , and you can attach the trace to an email to
LKML so we can review it (compress it if it's big though) .

Daniel

