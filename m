Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSFTOnD>; Thu, 20 Jun 2002 10:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSFTOnC>; Thu, 20 Jun 2002 10:43:02 -0400
Received: from quark.didntduck.org ([216.43.55.190]:28936 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S314634AbSFTOnB>; Thu, 20 Jun 2002 10:43:01 -0400
Message-ID: <3D11E9ED.7060101@didntduck.org>
Date: Thu, 20 Jun 2002 10:42:53 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: devnull@adc.idt.com
CC: linux-kernel@vger.kernel.org
Subject: Re: >3G Memory support
References: <Pine.GSO.4.31.0206201010340.13158-100000@bom.adc.idt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devnull@adc.idt.com wrote:
>>>When i compiled my kernel, i set CONFIG_HIGHMEM4G.
>>>
>>>Does this mean that all my programs should be able to address 4G ?
>>
>>No.  It means the kernel can access all 4GB of memory.  For memory above
>>the 950MB that it can directly map, it needs to use dynamic mappings
>>(kmap).  User space is always 3GB virtual space per process, regardless
>>of the highmem setting.
> 
> 
> Is there a way to make a process in the user space to able to access 4GB
> at all. 

Not all at one time, but you can map/unmap shared memory segments to 
access more memory.

> What limits user space to 3GB.

Hardware limitations imposed by the x86 architecture.  The x86 only has 
_one_ virtual address space, which has to be shared by user space and 
kernel space.  It is not possible to give user space more virtual 
address space without taking it away from the kernel.

> If not in current 2.4.x / 2.5.x, is this something planned in the future
> releases ?

Support for 64-bit processors like Intel Itanium and AMD Hammer 
processors which do not have such limitations.

--
				Brian Gerst

