Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUEVINY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUEVINY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUEVINY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:13:24 -0400
Received: from zero.aec.at ([193.170.194.10]:6149 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264910AbUEVINP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:13:15 -0400
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
References: <1XCh4-1jO-67@gated-at.bofh.it> <1XRg3-4LW-31@gated-at.bofh.it>
	<1XRg3-4LW-29@gated-at.bofh.it> <1XSc3-5y3-23@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 22 May 2004 10:13:01 +0200
In-Reply-To: <1XSc3-5y3-23@gated-at.bofh.it> (Andrew Morton's message of
 "Sat, 22 May 2004 02:00:14 +0200")
Message-ID: <m3iseoq3qq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Rusty Russell <rusty@rustcorp.com.au> wrote:
>>
>> On Thu, 2004-05-20 at 17:32, Andrew Morton wrote:
>> > I think what you want here is
>> > 
>> > 	if (!cpu_possible(cpu) || !cpu_online(cpu))
>> > 		return -ENXIO;
>> 
>> It works, but it's not really correct.  cpu_possible() is correct, but
>> cpu_online() might no longer be true by the time do_cpu_read() calls
>> do_cpu_id().
>
> mutter.  Are we likely to see any ia32 or x86_64 hotplug-cpu machines?

Yes. Think vmware and virtualization, where partitions could get CPUs 
added and removed at runtime.

-Andi

