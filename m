Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWDTTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWDTTxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWDTTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:53:44 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:58592 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751195AbWDTTxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:53:44 -0400
Message-ID: <4447E6C4.9070207@compro.net>
Date: Thu, 20 Apr 2006 15:53:40 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dmarkh@cfl.rr.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages ?
References: <44475DBA.7020308@cfl.rr.com> <44477585.4030508@yahoo.com.au>
In-Reply-To: <44477585.4030508@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Mark Hounschell wrote:
>> For some reason (unknown to me) the VM_IO and even newer VM_PFNMAP
>> vm_flags are set when I use this call causing it to fail for me. I'm
>> currently using 2.6.16.9 on an x86 platform.
> 
> [...]
> 
>> I'm not the author of any of this code so please gentle with me. Nor do
>> I have much of an understanding of the vm system. Any help in how this
>> task should really be accomplished, taken the stated limitations of the
>> pci card in mind, would be greatly appreciated. And any help as to what
>> would just make it work again would also be greatly appreciated. As I
>> stated above this all worked fine until the VM_PFNMAP bit was added to
>> the vm->flags and subsequently checked for in the get_user_pages call.
> 
> remap_pfn_range isn't the best API for someone who needs get_user_pages.
> remap_pfn_range operates on the pfn level only, so underlying addresses
> may not even have a struct page.
> 
> This area is going through some changes lately. If you want something to
> quickly get things working, removing VM_PFNMAP from your vma flags should
> work.
> 

Yes, that actually does work while the task is running but as soon as I
exit the task the machine freezes.

Mark
