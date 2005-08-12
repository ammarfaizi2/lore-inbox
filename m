Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVHLTyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVHLTyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVHLTyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:54:25 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:61924 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750735AbVHLTyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:54:24 -0400
In-Reply-To: <20050812204617.C21152@flint.arm.linux.org.uk>
References: <20050812204617.C21152@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6BFA4E5B-6123-4D99-A1FF-4FDCD1E9B25A@freescale.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel list <linux-kernel@vger.kernel.org>,
       Vitaly Bordug <vbordug@ru.mvista.com>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] cpm_uart: Fix spinlock initialization
Date: Fri, 12 Aug 2005 14:54:07 -0500
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 12, 2005, at 2:46 PM, Russell King wrote:


> On Fri, Aug 12, 2005 at 11:32:57AM -0500, Kumar Gala wrote:
>
>
>> The lack of spin_lock_init causes badness in the preempt
>>
>>
> configuration.
>
> Please don't - I have a patch in the wings which fixes this properly.
> Unfortunately, its behind a ton of other patches, and I don't want
> to try to find all these fixes in each driver.
>
> This is wrong because we will re-initialise it from an indeterminant
> state (it might be locked) later during the initialisation.  Let's
> fix it properly.
>
> (Since Linus pulled the shutters down when I still had a large chunk
> of stuff in my serial tree, my serial patch merging is currently at
> a complete standstill.)
>

Understood.  I'm fine with holding off for your proper fix.

Andrew, let's drop this patch.

- kumar

