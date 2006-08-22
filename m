Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWHVRQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWHVRQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWHVRQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:16:34 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:7345 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932189AbWHVRQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:16:33 -0400
Message-ID: <44EB3BF0.3040805@vmware.com>
Date: Tue, 22 Aug 2006 10:16:32 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <44DB7596.6010503@goop.org> <1156254965.27114.17.camel@localhost.localdomain> <200608221544.26989.ak@muc.de>
In-Reply-To: <200608221544.26989.ak@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I don't see why paravirt ops is that much more sensitive
> than most other kernel code. 
>
>   
>> It would be a lot safer if we could have the struct paravirt_ops in
>> protected read-only const memory space, set it up in the core kernel
>> early on in boot when we play "guess todays hypervisor" and then make
>> sure it stays in read only (even to kernel) space.
>>     
>
> By default we don't make anything read only because that would
> mess up the 2MB kernel mapping.
>
> In general i don't think making select code in the kernel
> read only is a good idea, because as long as you don't
> protect everything including stacks etc. there will be always
> attack points where supposedly protected code relies 
> on unprotected state. If someone can write to kernel
> memory you already lost.
>
> And it adds TLB pressure.
>   

And it doesn't work for VMI or lhype, both of which might modify 
paravirt_ops way later in the boot process, when loaded as a module.  
Where did this conversation come from?  I don't see it on any list I'm 
subscribed to.

Zach
