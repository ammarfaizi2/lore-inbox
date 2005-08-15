Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVHOX2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVHOX2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVHOX2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:28:03 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:5847 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S932574AbVHOX2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:28:02 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andi Kleen <ak@suse.de>
Cc: zach@vmware.com, akpm@osdl.org, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Mon, 15 Aug 2005 16:27:37 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH 0/6] i386 virtualization patches, Set 3
In-Reply-To: <20050815232400.GV27628@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0508151626290.24315@qynat.qvtvafvgr.pbz>
References: <200508152258.j7FMw9p8005295@zach-dev.vmware.com>
 <20050815232400.GV27628@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, Andi Kleen wrote:

> 
> On Mon, Aug 15, 2005 at 03:58:09PM -0700, zach@vmware.com wrote:
>> I was going to attempt to clean up the math-emu code to make it use the
>> nice new segment and descriptor table accessors, but it quickly became
>> apparent that this would be a long, tedious, error prone process that
>> would eventually result in the death of a large section of my brain.
>> In addition, it is not very fun to test this on the actual hardware it
>> is designed to run on (although I did manage to track down a 386 with
>> detachable i387 coprocessor, the owner is not sure it still boots).
>> Someday it would be nice to have an audit of this code; it appears to
>> be riddled with bugs relating to segmentation, for example it assumes
>> LDT segments on overrides, does not use the mm->context semaphore to
>> protect LDT access, and generally looks scarily out of date in both
>> function and appearance.
>
> Perhaps the best would be to just remove it. Near all 386s should be far
> beyond their MTBF by now. Mark it CONFIG_BROKEN and if nobody complains for
> one or two releases remove it completely.

you are forgetting about the embedded market, there 386 cpu (or things 
that look like 386 cpu's) are still available.

David Lang

> The ugly verify_area 386 bugfix workaround code could go at the same
> time.
>
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
