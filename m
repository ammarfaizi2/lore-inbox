Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbTIIVvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbTIIVvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:51:54 -0400
Received: from [202.37.96.11] ([202.37.96.11]:27534 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S264625AbTIIVvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:51:51 -0400
Date: Wed, 10 Sep 2003 09:54:20 +1200
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: Re: Problem with remap_page_range
In-reply-to: <20030909100235.A20267@home.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <3F5E4C0C.1080303@tait.co.nz>
Organization: Tait Electronics Ltd
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
References: <3F5E7ACD.8040106@tait.co.nz> <20030909100235.A20267@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>  if (remap_page_range(vma->vm_start,
>>                       DSP_ADDR,
>>                       size,
>>                       vma->vm_page_prot
>>                       ))
>>    
>>
>
>Your remap call isn't adding _PAGE_NO_CACHE and _PAGE_GUARDED flags
>like ioremap_nocache()/ioremap() do on PPC.  You'll get bad results
>because of the ordering and cache issues resulting from not using
>these PTE flags.  In 2.6, these can be added using pgprot_noncached()
>that is defined per-arch.
>
>  
>
Thank you Matt,

Coud you please give me en example on how to add these flags to remap in 
kernel 2.4.21 (powerpc).
It seems I could not find these flags available in my kernel.

Thank you very much



