Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVDEUy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVDEUy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVDEUoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:44:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38069 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261964AbVDEUlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:41:31 -0400
Message-ID: <4252F7ED.6050908@pobox.com>
Date: Tue, 05 Apr 2005 16:41:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Josselin Mouette <joss@debian.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 	copyright notice.
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br>	 <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com> <1112723637.4878.14.camel@mirchusko.localnet> <4252E6C1.5010701@pobox.com> <4252F23B.6080402@didntduck.org>
In-Reply-To: <4252F23B.6080402@didntduck.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Jeff Garzik wrote:
> 
>> Josselin Mouette wrote:
>>
>>> Finally, you shouldn't forget that, technically speaking, using hotplug
>>> for uploading the firmware is much more flexible and elegant than
>>> including it in the kernel. Upgrading the firmware and the module should
>>> be two independent operations. People who are advocating the current
>>> situation are refusing technical improvements just because they are
>>> brought by people they find convenient to call "zealots".
>>
>>
>>
>> This is highly amusing, coming from someone who does not maintain a 
>> driver with a firmware.
>>
>> The current firmware infrastructure is too primitive.  Compiling the 
>> firmware into the driver is much easier on the driver maintainers and 
>> users, presently.
>>
>> Repeating myself,
>>
>> * Most firmwares are a -collection- of images and data.  The firmware 
>> infrastructure should load an -archive- of firmwares and associated 
>> data values.
> 
> 
> The firmware interface should only be concerned with getting the blob of 
> data into kernel space.  Once it is in kernel space the driver can parse 
> out whatever archive format it is in.  Take for example the ihex code 
> that was posted recently.  Similar code could be written to parse out a 
> tarball, cpio archive, etc.

The archive format for firmware data collections must be standardized, 
and generic code for loading such collections needs to be written, not 
duplicated into each driver.

Obviously the driver-specific data inside the archive is, as the phrase 
implies, driver-specific.

	Jeff



