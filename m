Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVK0Oci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVK0Oci (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVK0Oci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:32:38 -0500
Received: from eastrmmtao06.cox.net ([68.230.240.33]:46586 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751077AbVK0Och (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:32:37 -0500
In-Reply-To: <4389B80C.8040405@shadowen.org>
References: <44E57FC6-A500-42B7-86F9-F1F4E72734EC@mac.com> <4389B80C.8040405@shadowen.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <23E90BC5-8F56-4DC3-BD4C-61B661FE1475@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6.15-rc2-mm1] Disabled flatmem on ppc32? (ARCH=powerpc)
Date: Sun, 27 Nov 2005 09:32:35 -0500
To: Andy Whitcroft <apw@shadowen.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 27, 2005, at 08:43:40, Andy Whitcroft wrote:

> Kyle Moffett wrote:
>
>
>> There is a Kconfig problem for ppc32 in the latest -mm kernel.  It  
>> seems that somehow the Kconfig logic for selecting memory models   
>> under ARCH=powerpc doesn't quite get it right for standard  
>> flatmem  ppc32 systems.  When I look at the memory model  
>> selection, I only see sparsemem, whereas on a normal -rc2 kernel,  
>> I can see both flatmem and sparsemem.  This somehow triggers a  
>> #error where the number of reserved bits is less than the number  
>> necessary for the sparsemem layout (because we're on a 32-bit arch  
>> without the address space for  sparsemem?).
>>
>
> I suspect we have neglected to add back the default for FLATMEM on  
> 32 bit when we allowed FLATMEM to be disabled for 64 bit.  Will go  
> and look at it.  Thanks for the report.
>

When you get it figured out, could you CC the patch to me?  I'd like  
to do some testing -mm1 and this is a bit of a showstopper :-D.  Thanks!

Cheers,
Kyle Moffett


