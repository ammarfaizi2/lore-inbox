Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWJQR5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWJQR5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWJQR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:57:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39578 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751367AbWJQR5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:57:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
References: <5986589C150B2F49A46483AC44C7BCA412D6E7@ssvlexmb2.amd.com>
Date: Tue, 17 Oct 2006 11:55:34 -0600
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D6E7@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Mon, 16 Oct 2006 12:52:06 -0700")
Message-ID: <m18xjeaktl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

>>So to get things going making TARGET_CPUS cpu_online_map looks like
>>the right thing to do.
>
> Yes. but need to other reference to TARGET_CPUS to verify...it doesn't
> break sth.

I just looked and tested and we are fine.

>>My question is are your io_apics pci devices?  Not does the kernel
>>have them.
>
> Yes, I'm testing with 32 amd8132 in the simulator. Or forget about about
> ioapic, and use MSI, and HT-irq directly...?

Ok.  So if want a pci device we can have one :)
Usually what I have seen is that all io_apics except the
first one show up as pci devices.

>>There are a lot of ways we can approach assigning irqs to cpus and
> there
>>is a lot of work there.  I think Adrian Bunk has been doing some work
>>with the user space irq balancer, and should probably be involved.
>
> Right. We need only do needed in kernel space, and leave most to irq
> balancer.

Actually I was just being pragmatic.  Make it work now.  Make it optimal
later :)

Eric
