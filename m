Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWHGRr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWHGRr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWHGRr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:47:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63904 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750808AbWHGRr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:47:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<20060807085924.72f832af.rdunlap@xenotime.net>
	<m1irl4ebsf.fsf@ebiederm.dsl.xmission.com>
	<44D771A7.7040605@zytor.com>
Date: Mon, 07 Aug 2006 11:46:25 -0600
In-Reply-To: <44D771A7.7040605@zytor.com> (H. Peter Anvin's message of "Mon,
	07 Aug 2006 10:00:23 -0700")
Message-ID: <m1k65kcuby.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>> a) Because I would like to flush out bugs.
>> b) Because I want a default that works for everyone.
>> c) Because with MSI we have a potential for large irq counts on most systems.
>> d) Because anyone who disagrees with me can send a patch and fix
>>    the default.
>> e) Because with the default number of cpus we can very close to needing
>>    this many irqs in the worst case.
>> f) This is much better than previous to my patch and setting NR_CPUS=255
>>    and getting 8K IRQS.
>> g) Because I probably should have been more inventive than copying the
>>    NR_IRQS text, but when I did the wording sounded ok to me.
>>
>
> Why not simply reserve 224*NR_CPUS IRQs? If you have 256 CPUs allocating 64K
> IRQs should hardly matter :)

Well there is this little matter of 224*NR_CPUS*NR_CPUS counters at that point
that I think would be prohibitive for most sane people.  Taking 224K of per cpu
memory in 256 different per cpu areas.

Still what is 56MB when you have a terrabyte of RAM. :)

Eric
