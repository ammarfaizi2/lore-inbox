Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWHPHtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWHPHtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWHPHtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:49:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5791 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750990AbWHPHtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:49:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       mm-commits@vger.kernel.org
Subject: Re: - simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch removed from -mm tree
References: <200608141803.k7EI3Plc024729@shell0.pdx.osdl.net>
	<m1veot99ua.fsf@ebiederm.dsl.xmission.com>
	<20060816.100750.08077480.nemoto@toshiba-tops.co.jp>
Date: Wed, 16 Aug 2006 01:48:48 -0600
In-Reply-To: <20060816.100750.08077480.nemoto@toshiba-tops.co.jp> (Atsushi
	Nemoto's message of "Wed, 16 Aug 2006 10:07:50 +0900 (JST)")
Message-ID: <m1bqql5den.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> writes:

> On Tue, 15 Aug 2006 11:39:57 -0600, ebiederm@xmission.com (Eric W. Biederman)
> wrote:
>> >      simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
>> >
>> > This patch was dropped because it had testing failures
>> 
>> Thanks.  I didn't see a thread on linux-kernel for this so I
>> just wanted to report that this patch killed my boot when the
>> serial driver initialized, and at some other point as well when
>> I did not compile in the serial driver.
>> 
>> Just in case an additional data point was needed.
>
> I posted a patch to fix this failure.  Please try with it.  Thanks.
>
> http://lkml.org/lkml/2006/8/15/135
>
> I'll cook a new patch including this fix and AVR32 do_timer fix.

My kernel boots now, so I guess that fixes my bug.
Advancing the clock by negative jiffies.  Ouch!

Eric
