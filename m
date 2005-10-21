Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVJUSCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVJUSCO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVJUSCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:02:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18862 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965049AbVJUSCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:02:13 -0400
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
References: <20051021165352.22654.qmail@web25806.mail.ukl.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 21 Oct 2005 12:01:49 -0600
In-Reply-To: <20051021165352.22654.qmail@web25806.mail.ukl.yahoo.com> (Albert
 Herranz's message of "Fri, 21 Oct 2005 18:53:52 +0200 (CEST)")
Message-ID: <m164rqeoky.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Herranz <albert_herranz@yahoo.es> writes:

>> > Should the local_irq_disable() call go away onece
>> local_irq_save() got
>> > introduced.
>> 
>> Nope.  The irqs need to be disabled.  The save just
>> allows this
>> to be called in a context where irqs start out
>> disabled.  It is
>> just a save.
>
> local_irq_save() also disables interrupts.

Bah.  I was thinking and reading local_save_flags()....

So yes that does make the local_irq_disable redundant.

I still used to seeing:
save_flags();
cli();
...
restore_flags();

Eric


