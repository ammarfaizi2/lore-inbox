Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVAJPvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVAJPvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVAJPvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:51:15 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50833
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262295AbVAJPvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:51:07 -0500
Message-ID: <53311.212.184.22.162.1105372175.squirrel@www.tglx.de>
In-Reply-To: <20050110145615.GC2226@smtp.west.cox.net>
References: <20050110013508.1.patchmail@tglx>
    <1105318804.17853.5.camel@tglx.tec.linutronix.de>
    <20050110145615.GC2226@smtp.west.cox.net>
Date: Mon, 10 Jan 2005 16:49:35 +0100 (CET)
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [3/3]
From: tglx@linutronix.de
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
       "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 10, 2005 at 02:00:04AM +0100, Thomas Gleixner wrote:
>
>> This patch adjusts the PPC entry code to use the fixed up
>> preempt_schedule() handling in 2.6.10-mm2
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>
>> ---
>>  entry.S |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>> ---
>> Index: 2.6.10-mm1/arch/ppc/kernel/entry.S
>> ===================================================================
>> --- 2.6.10-mm1/arch/ppc/kernel/entry.S  (revision 141)
>> +++ 2.6.10-mm1/arch/ppc/kernel/entry.S  (working copy)
>> @@ -624,12 +624,12 @@
>>         beq+    restore
>>         andi.   r0,r3,MSR_EE    /* interrupts off? */
>>         beq     restore         /* don't schedule if so */
>> -1:     lis     r0,PREEMPT_ACTIVE@h
>> +1:     li      r0,1
>
> Perhaps I just don't have enough context, but is there good reason to
> use a magic constant instead of a define ?
>

True. I will wait for Ingo's final solution and fix this proper.

tglx



