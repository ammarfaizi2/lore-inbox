Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVK2ERO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVK2ERO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVK2ERO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:17:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39864 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750730AbVK2ERN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:17:13 -0500
To: Andi Kleen <ak@suse.de>
Cc: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH 1/4] stack overflow safe kdump (i386) -
 safe_smp_processor_id
References: <1133200833.2425.100.camel@localhost.localdomain>
	<p738xv8id6r.fsf@verdi.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 28 Nov 2005 21:16:20 -0700
In-Reply-To: <p738xv8id6r.fsf@verdi.suse.de> (Andi Kleen's message of "28
 Nov 2005 16:07:40 -0700")
Message-ID: <m1d5kkf5rf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:
>> 
>> To circumvent this problem I suggest implementing
>> "safe_smp_processor_id()" (it already exists on x86_64) for i386 and
>> IA64 and use it as a replacement to smp_processor_id in the reboot path
>> to the dump capture kernel. This is a possible implementation for i386.
>
> It's not fully safe, because a SMP kernel might run on a 32bit
> system without APIC. Then hard_smp_processor_id() would fault. 
> (this cannot happen on x86-64)
>
> You probably need to check one of the globals set by apic.c
> when its disabled.

Right.  An SMP kernel on a uniprocessor, without apics.

To my knowledge all SMP systems that linux supports have
apics.

Eric

