Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265483AbUEZLXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbUEZLXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265484AbUEZLXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:23:18 -0400
Received: from zero.aec.at ([193.170.194.10]:58885 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265483AbUEZLXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:23:17 -0400
To: Andrew Morton <akpm@osdl.org>
cc: akiyama.nobuyuk@jp.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI trigger switch support for debugging
References: <1ZjWz-sq-11@gated-at.bofh.it> <1Zk6a-z2-3@gated-at.bofh.it>
	<1ZVyO-63D-25@gated-at.bofh.it> <1ZVIq-69O-3@gated-at.bofh.it>
	<1ZWuM-6Nz-1@gated-at.bofh.it> <1ZWEt-6Uw-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 26 May 2004 13:23:12 +0200
In-Reply-To: <1ZWEt-6Uw-1@gated-at.bofh.it> (Andrew Morton's message of
 "Wed, 26 May 2004 04:50:05 +0200")
Message-ID: <m3smdn4elb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com> wrote:
>>
>> Sorry, I resend document and patch.
>
> Great, thanks.  Updates to Documentation/kernel-parameters.txt and
> Documentation/filesystems/proc.txt would be nice.
>
>
> If the machine locks up with interrupts enabled we can use sysrq-T and
> sysrq-P.  If it locks up with interrupts disabled the NMI watchdog will
> automatically produce the same info as your patch.  So what advantage does
> the patch add?

His patch will still work e.g. if the interrupt locks are messed up.
Then the keyboard interrupt will not work anymore, but NMI will.
Arguably a bit obscure, but could happen.

The bigger advantage I see from the patch (and why i like it) is 
that distributions often disable sysrq by default for security
reasons. This is not really needed for this NMI oopser, since you
can assume that someone with access to the NMI switch can crash the
machine at will.

-Andi

