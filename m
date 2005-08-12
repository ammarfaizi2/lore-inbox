Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVHLCde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVHLCde (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVHLCde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:33:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44501 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750740AbVHLCdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:33:33 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 3/8] [PATCH] x86_64: Fixing smpboot timing problem
References: <20050811225445.404816000@localhost.localdomain>
	<20050811225609.058881000@localhost.localdomain>
	<20050811233302.GA8974@wotan.suse.de>
	<20050811234343.GF7762@shell0.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 11 Aug 2005 20:32:08 -0600
In-Reply-To: <20050811234343.GF7762@shell0.pdx.osdl.net> (Chris Wright's
 message of "Thu, 11 Aug 2005 16:43:43 -0700")
Message-ID: <m1ll37x4uv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> * Andi Kleen (ak@suse.de) wrote:
>> >  static void __cpuinit tsc_sync_wait(void)
>> >  {
>> >  	if (notscsync || !cpu_has_tsc)
>> >  		return;
>> > - printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n", smp_processor_id(),
>> > -			boot_cpu_id);
>> > -	sync_tsc();
>> > +	sync_tsc(boot_cpu_id);
>> 
>> I actually found a bug in this today. This should be sync_tsc(0), not
> sync_tsc(boot_cpu_id)
>> Can you just fix it in your tree or should I submit a new patch? 
>
> I'll fix it locally.  Thanks for the heads-up.

Someone needs to send the patch to Linus for 2.6.13 as well.  Is someone
else going to or should I.  I knew I was confused about physical versus
logical apic ids when I generated the patch.

Eric
