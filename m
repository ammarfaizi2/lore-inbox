Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVDEV3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVDEV3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVDEV0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:26:50 -0400
Received: from quark.didntduck.org ([69.55.226.66]:13769 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262045AbVDEVNA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:13:00 -0400
Message-ID: <4252FF89.2040206@didntduck.org>
Date: Tue, 05 Apr 2005 17:13:45 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Josselin Mouette <joss@debian.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 	copyright notice.
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br>	 <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com> <1112723637.4878.14.camel@mirchusko.localnet> <4252E6C1.5010701@pobox.com> <4252F23B.6080402@didntduck.org> <4252F7ED.6050908@pobox.com>
In-Reply-To: <4252F7ED.6050908@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Brian Gerst wrote:
> 
>> Jeff Garzik wrote:
>>
>>> Josselin Mouette wrote:
>>>
>>>> Finally, you shouldn't forget that, technically speaking, using hotplug
>>>> for uploading the firmware is much more flexible and elegant than
>>>> including it in the kernel. Upgrading the firmware and the module 
>>>> should
>>>> be two independent operations. People who are advocating the current
>>>> situation are refusing technical improvements just because they are
>>>> brought by people they find convenient to call "zealots".
>>>
>>>
>>>
>>>
>>> This is highly amusing, coming from someone who does not maintain a 
>>> driver with a firmware.
>>>
>>> The current firmware infrastructure is too primitive.  Compiling the 
>>> firmware into the driver is much easier on the driver maintainers and 
>>> users, presently.
>>>
>>> Repeating myself,
>>>
>>> * Most firmwares are a -collection- of images and data.  The firmware 
>>> infrastructure should load an -archive- of firmwares and associated 
>>> data values.
>>
>>
>>
>> The firmware interface should only be concerned with getting the blob 
>> of data into kernel space.  Once it is in kernel space the driver can 
>> parse out whatever archive format it is in.  Take for example the ihex 
>> code that was posted recently.  Similar code could be written to parse 
>> out a tarball, cpio archive, etc.
> 
> 
> The archive format for firmware data collections must be standardized, 
> and generic code for loading such collections needs to be written, not 
> duplicated into each driver.

I never said code shouldn't be standardized or shared.  I just said that 
it is a seperate function from the process of transferring the data from 
userspace to kernel space.  That said, initramfs already uses cpio, so 
that would be a good choice to use.

--
				Brian Gerst
