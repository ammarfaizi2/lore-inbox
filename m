Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVJDP2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVJDP2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVJDP2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:28:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9436 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932531AbVJDP2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:28:13 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [PATCH 1/2] x86_64 nmi_watchdog: Make check_nmi_watchdog static
References: <m17jct8ggh.fsf@ebiederm.dsl.xmission.com>
	<200510041721.09736.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 09:26:45 -0600
In-Reply-To: <200510041721.09736.ak@suse.de> (Andi Kleen's message of "Tue,
 4 Oct 2005 17:21:09 +0200")
Message-ID: <m1y859716y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 04 October 2005 17:11, Eric W. Biederman wrote:
>> By using a late_initcall as i386 does we don't need to call
>> check_nmi_watchdog manually after SMP startup, and we don't
>> need different code paths for SMP and non SMP.
>>
>> This paves the way for moving apic initialization into init_IRQ,
>> where it belongs.
>
> I don't like it. I want to see a clear message in the log when
> the NMI watchdog doesn't work and with your patch that comes too late.

Why is it to late?

> -Andi (who has rejected similar patches before)

Would it be more appropriate to make this a per cpu check?  
I am just trying to make the code path clean so we don't have
special SMP/non-SMP logic.  Anything that achieves that is
fine with me.

Eric

