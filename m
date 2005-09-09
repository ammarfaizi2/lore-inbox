Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVIIHMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVIIHMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVIIHMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:12:49 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:43212
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751421AbVIIHMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:12:49 -0400
Message-Id: <4321525102000078000247C2@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 09:13:53 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] [PATCH] add and handle NMI_VECTOR II
References: <43207DFC0200007800024543@emea1-mh.id2.novell.com>  <20050909004307.GA18347@wotan.suse.de>  <43214AE402000078000247AB@emea1-mh.id2.novell.com> <200509090855.52752.ak@suse.de>
In-Reply-To: <200509090855.52752.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Index: linux/arch/x86_64/kernel/traps.c
>>
>===================================================================
>> >--- linux.orig/arch/x86_64/kernel/traps.c
>> >+++ linux/arch/x86_64/kernel/traps.c
>> >@@ -931,7 +931,7 @@ void __init trap_init(void)
>> > 	set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);
>> > #endif
>> >
>> >-	set_intr_gate(KDB_VECTOR, call_debug);
>> >+	set_intr_gate(NMI_VECTOR, call_debug);
>> >
>> > 	/*
>> > 	 * Should be a barrier for any external CPU state.
>>
>> I never understood what this does. If you deliver the IPI as an
NMI,
>> it'll never arrive at this vector, and why would anyone want to put
an
>> "int $NMI_VECTOR" anywhere?
>
>You can force an NMI when sending an IPI by setting the right bits
>in ICR. That is what it is used for.

??? This is what the code doing the setup does. But the question was -
what do you need the IDT entry for?

Jan
