Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUI2WDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUI2WDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUI2WDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:03:12 -0400
Received: from zero.aec.at ([193.170.194.10]:44045 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269072AbUI2WDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:03:09 -0400
To: Tim Bird <tim.bird@am.sony.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a problem in timeval_to_jiffies?
References: <2CxDn-2ib-51@gated-at.bofh.it> <2DDGs-7Om-31@gated-at.bofh.it>
	<2EVhQ-6Qe-5@gated-at.bofh.it> <2F1e7-2r9-21@gated-at.bofh.it>
	<2Fb3o-1cT-27@gated-at.bofh.it> <2Fb3o-1cT-25@gated-at.bofh.it>
	<2FnQM-1wt-1@gated-at.bofh.it> <2JTS7-5Ri-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 30 Sep 2004 00:03:03 +0200
In-Reply-To: <2JTS7-5Ri-3@gated-at.bofh.it> (Tim Bird's message of "Wed, 29
 Sep 2004 23:10:07 +0200")
Message-ID: <m3d604u414.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird <tim.bird@am.sony.com> writes:

> Henry Margies wrote:
>> Right? But for arm, with a jiffie size of 10000000, it is much
>> more easier. And that is why I don't understand why an one second
>> interval is converted to 101 jiffies (on arm).
> ...
>> I agree. But then, why adding one jiffie to every interval? If
>> there is no latency, the timer should appear right at the
>> beginning of a jiffie. For x86 you are right, because 10 jiffies
>> are less then 10ms. But for arm, 1 jiffie is precisely 10ms. 
>
> How does the computer "know" that the timer is at the beginning
> of the jiffy?  By definition, Linux (without HRT support) has

do_gettimeofday() or better the posix monotonic clock normally have 
much better resolution than a jiffie (on x86 typically the resolution
of the CPU clock) xtime is the T-O-D of the last jiffie
However calling do_gettimeofday and doing the calculation may 
be too expensive.

-Andi

