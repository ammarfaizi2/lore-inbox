Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVJDPtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVJDPtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVJDPtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:49:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25052 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964822AbVJDPtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:49:32 -0400
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [PATCH] i386: move apic init in init_IRQs
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61L.0510041628160.10696@blysk.ds.pg.gda.pl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 09:48:01 -0600
In-Reply-To: <Pine.LNX.4.61L.0510041628160.10696@blysk.ds.pg.gda.pl> (Maciej
 W. Rozycki's message of "Tue, 4 Oct 2005 16:34:35 +0100 (BST)")
Message-ID: <m1psql707i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@linux-mips.org> writes:

> On Tue, 4 Oct 2005, Eric W. Biederman wrote:
>
>> -	if (enable_local_apic < 0)
>> -		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
>
>  I think this should stay.

lapic_disable() already does this.  I am just testing the results.

>> +	if (enable_local_apic < 0) {
>> +		printk(KERN_INFO "Apic disabled\n");
>
>  Capitalisation. ;-)
>
>  Otherwise it seems reasonable -- provided it works for you. ;-)

So what should the capitalization be? "APIC disabled\n" ?

Sorry.

Eric


