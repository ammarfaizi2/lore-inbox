Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWHGSRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWHGSRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWHGSRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:17:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11662 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750789AbWHGSRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:17:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<20060807085924.72f832af.rdunlap@xenotime.net>
	<m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com>
	<20060807105537.08557636.rdunlap@xenotime.net>
Date: Mon, 07 Aug 2006 12:16:14 -0600
In-Reply-To: <20060807105537.08557636.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Mon, 7 Aug 2006 10:55:37 -0700")
Message-ID: <m13bc8csy9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

>> 
>> This of course applies to the -mm tree because the rest
>> of the irq work is not yet in the mainline kernel.
>> 
>>  arch/x86_64/Kconfig      |   14 ++++++++++++++
>>  include/asm-x86_64/irq.h |    3 ++-
>>  2 files changed, 16 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
>> index 7598d99..cea78d7 100644
>> --- a/arch/x86_64/Kconfig
>> +++ b/arch/x86_64/Kconfig
>> @@ -384,6 +384,20 @@ config NR_CPUS
>>  	  This is purely to save memory - each supported CPU requires
>>  	  memory in the static kernel configuration.
>
> Thanks for the language fixes.
> I'm confused about one thing.  What is NR_IRQS for non-SMP?
> Does it default to 4096 or something else?

Right the default is still 4096 which is fairly silly.

> Does this build on non-SMP?  Is CONFIG_NR_IRQS defined for non-SMP?

Ugh.  I have a "depends on SMP" line in there.  That shouldn't be.
Ok.  I need to fix the non SMP case, at least take out the dependency
and if I'm clever move the default down to 224.

Eric
