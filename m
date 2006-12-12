Return-Path: <linux-kernel-owner+w=401wt.eu-S1750856AbWLLBqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWLLBqp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWLLBqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:46:45 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:52763 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbWLLBqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:46:44 -0500
Message-ID: <457E0A03.3020704@vmware.com>
Date: Mon, 11 Dec 2006 17:46:43 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
References: <457E0460.4030107@goop.org> <457E08FE.6050600@vmware.com> <457E097C.5030208@goop.org>
In-Reply-To: <457E097C.5030208@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>> Jeremy Fitzhardinge wrote:
>>     
>>> Hi Andi,
>>>
>>> What problem do they cause together?  There's certainly no problem with
>>> Xen+vdso (in fact, its actually very useful so that it picks up the
>>> right libc with Xen-friendly TLS).
>>>   
>>>       
>> Methinks the compat VDSO support got broken in the config?  Paravirt +
>> COMPAT_VDSO are incompatible. 
>>     
>
> Yes, that's true, but I'm looking at arch/i386/kernel/sysenter.c:
>
> #ifdef CONFIG_PARAVIRT
> unsigned int __read_mostly vdso_enabled = 0;
> #else
> unsigned int __read_mostly vdso_enabled = 1;
> #endif
>
> I can't think of any reason why that should be necessary.
>   

It's not for us or Xen.  Perhaps it came from lhype?  
