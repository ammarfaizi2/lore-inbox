Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUIPIea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUIPIea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 04:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUIPIea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 04:34:30 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:3854 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267860AbUIPIe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 04:34:26 -0400
Message-ID: <4149512E.9040005@hist.no>
Date: Thu, 16 Sep 2004 10:39:10 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Lee Revell <rlrevell@joe-job.com>, Ricky Beam <jfbeam@bluetronic.net>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
References: <Pine.GSO.4.33.0409151255240.10693-100000@sweetums.bluetronic.net> <1095270555.2406.154.camel@krustophenia.net> <41488140.4050109@pobox.com>
In-Reply-To: <41488140.4050109@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Lee Revell wrote:
>
>> Interesting.  Still, this looks like a specific bug that needs fixing,
>> it doesn't imply that preemption is a hack.  For many workloads
>> preemption is a necessity.
>
>
>
> For any workload that you feel preemption is a necessity, that 
> indicates a latency problem in the kernel that should be solved.
>
> Preemption is a hack that hides broken drivers, IMHO.
>
> I would rather directly address any latency problems that appear.

Current preempt is broken, sure.  But having robust preempt
would allow code simplification.  Long loops outside critical
sections would be ok - no time or code spent testing for a need for
rescheduling because you'll be preempted when necessary anyway.

Or am I missing something?  Other than that current preempt isn't up to
this and might be hard to get there?

Helge Hafting


