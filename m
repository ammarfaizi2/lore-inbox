Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUIVWvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUIVWvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUIVWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:51:46 -0400
Received: from zero.aec.at ([193.170.194.10]:11527 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268082AbUIVWv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:51:28 -0400
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: year 2038 problem on x86-64
References: <2HnMR-35F-55@gated-at.bofh.it> <2HnMR-35F-57@gated-at.bofh.it>
	<2HnMR-35F-53@gated-at.bofh.it> <2HnWp-3b7-25@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 23 Sep 2004 00:51:21 +0200
In-Reply-To: <2HnWp-3b7-25@gated-at.bofh.it> (Pavel Machek's message of
 "Thu, 23 Sep 2004 00:40:09 +0200")
Message-ID: <m3y8j19aty.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> >
>> > ... __ARCH_WANT_SYS_TIME actually is set on x86-64.
>> 
>> But it's not used. It declares an own sys_time64 in arch/x86_64
>> By default the vsyscall code is used.
>
> So should __ARCH_WANT_SYS_TIME be  killed from x86_64?

No. The 32bit emulation uses it.

In theory you could make it conditional on CONFIG_IA32_EMULATION,
but that would be probably overkill.

-Andi

