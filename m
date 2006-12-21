Return-Path: <linux-kernel-owner+w=401wt.eu-S1423041AbWLUVkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423041AbWLUVkv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWLUVkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:40:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51328 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423041AbWLUVku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:40:50 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work
References: <5986589C150B2F49A46483AC44C7BCA490731A@ssvlexmb2.amd.com>
Date: Thu, 21 Dec 2006 14:40:01 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA490731A@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Thu, 21 Dec 2006 13:24:44 -0800")
Message-ID: <m11wmtnd1q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> -----Original Message-----
> From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
> Sent: Thursday, December 21, 2006 12:47 PM
> To: Lu, Yinghai
>>> +static int add_irq_entry(int type, int irqflag, int bus, int irq,
> int apic, int
>>> pin)
>
>>This is fairly sane but probably belongs in mptable.c as a helper.
>
> mparse.c?

yep.

>>I am still trying to understand this enable_8259A_irq(0) case.
>>As far as I can tell this is a very backwards way of enabling
>>an ExtINT, as such it shouldn't be used until later.
>
>>YH do you have any insight why on some Nvidia chipsets we apic 0 pin 2
> doesn't
>>work for the timer interrupt.  I thought that was what we were using in
> LinuxBIOS
>>for the mptable.
>
> CK804's has problem. But later one seems fixed that problem.

Do you have any details?

Eric
