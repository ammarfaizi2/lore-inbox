Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTKUIkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTKUIkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:40:06 -0500
Received: from imap.gmx.net ([213.165.64.20]:10476 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264331AbTKUIj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:39:58 -0500
X-Authenticated: #4512188
Message-ID: <3FBDD055.50907@gmx.de>
Date: Fri, 21 Nov 2003 09:44:05 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4
References: <20031118225120.1d213db2.akpm@osdl.org>	<3FBDCCDF.9010304@gmx.de> <20031121004133.1a111786.akpm@osdl.org>
In-Reply-To: <20031121004133.1a111786.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Prakash K. Cheemplavam" <prakashpublic@gmx.de> wrote:
> 
>>DMESG gives me following:
>>
>> Debug: sleeping function called from invalid context at mm/slab.c:1868
>> in_atomic():1, irqs_disabled():0
>> Call Trace:
>>   [<c0120fbb>] __might_sleep+0xab/0xd0
>>   [<c0144fa5>] kmem_cache_alloc+0x65/0x70
>>   [<c0155161>] __get_vm_area+0x21/0xf0
>>   [<c0155263>] get_vm_area+0x33/0x40
>>   [<c011df03>] __ioremap+0xb3/0x100
>>   [<c011df79>] ioremap_nocache+0x29/0xb0
>>   [<f9a5ad87>] os_map_kernel_space+0x68/0x6c [nvidia]
>>   [<f9a6d377>] __nvsym00568+0x1f/0x2c [nvidia]
>>   [<f9a6f496>] __nvsym00775+0x6e/0xe0 [nvidia]
>>   [<f9a6f526>] __nvsym00781+0x1e/0x190 [nvidia]
>>   [<f9a70fac>] rm_init_adapter+0xc/0x10 [nvidia]
>>   [<f9a57dc9>] nv_kern_open+0xf3/0x228 [nvidia]
>>   [<c0164b40>] exact_match+0x0/0x10
>>   [<c0164941>] chrdev_open+0xf1/0x220
>>   [<c01aa332>] devfs_open+0xe2/0xf0
>>   [<c0159f32>] dentry_open+0x152/0x270
>>   [<c0159ddb>] filp_open+0x5b/0x60
>>   [<c015a2c3>] sys_open+0x53/0x90
>>   [<c041f532>] sysenter_past_esp+0x43/0x65
> 
> 
> That would be a locking error in the nvidia driver.

What does that mean and how to get rid of it?

Prakash

