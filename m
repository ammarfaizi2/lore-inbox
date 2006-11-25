Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966654AbWKYQ6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966654AbWKYQ6q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966694AbWKYQ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:58:45 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:37841
	"EHLO saville.com") by vger.kernel.org with ESMTP id S966654AbWKYQ6p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:58:45 -0500
Message-ID: <4568764B.7080505@saville.com>
Date: Sat, 25 Nov 2006 08:58:51 -0800
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: arjan@infradead.org
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de>	 <20061124202514.GA7608@elte.hu>  <4567B0CC.4030802@saville.com> <1164443423.3147.51.camel@laptopd505.fenrus.org>
In-Reply-To: <1164443423.3147.51.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

<snip/>

> 
> so you can live with an occasional jump of seconds/minutes between
> threads? Or when a thread moves to another cpu?
> (yes on many PCs you won't see minutes, but on others you will)
> 

No that probably wouldn't be acceptable a few thousand ticks might be Ok.
How hard would be it possible to detect post facto what corrections might be needed
when? Maybe an event or FIFO that would provide correction information.

I would also assume we could request that a thread not migrate between CPU's
if it was critical and that could be a solution.

Would another alternative be to allow the thread to indicate when it was
ready to migrate and at these points the correction information could
be supplied/retrieved if desired.

Actually, we need to ask the CPU/System makers to provide a system wide
timer that is independent of the given CPU. I would expect it quite simple
for the coming generations of multi-core CPU's to provide a shared TSC.
For the multi-processor embedded work I have done we provided a memory
mapped counter that all processors could read, that worked quite well:)

Wink

