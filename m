Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVAETRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVAETRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVAETRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:17:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:19881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262559AbVAETRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:17:37 -0500
Message-ID: <41DC3BD6.3020303@osdl.org>
Date: Wed, 05 Jan 2005 11:11:18 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Konrad Wojas <wojas@vvtp.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 oops in poll()?
References: <20050103161556.GD31250@vvtp.tudelft.nl> <41DB1C92.7060501@osdl.org> <20050105040841.GI31250@vvtp.tudelft.nl> <41DC30C9.5050402@osdl.org> <20050105185733.GJ31250@vvtp.tudelft.nl>
In-Reply-To: <20050105185733.GJ31250@vvtp.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Wojas wrote:
> On Wed, Jan 05, 2005 at 10:24:09AM -0800, Randy.Dunlap wrote:
> 
>>This probably needed to use /proc/kallsyms from the dying kernel,
>>which you most likely don't have....
>>
>>I'm having trouble seeing what sock_poll() called (i.e., where EIP
>>register points to).  In the /boot/System.map-2.6.9-1-686 file,
>>is anything near address 0xc02b5513 listed?
>>(or just send me that file privately)
> 
> 
> Also doesn't look very helpfull to me..

True.  Have you tested this problem on 2.6.10 yet?

Back to 2.6.9:  do you normally run 2.6.9 with all of those same
modules loaded?  If so, please send me the /proc/modules
and /proc/kallsyms files.

Anyone know what all of those __func__'s are?

> c02a592a r __func__.1
> c02a593b r __func__.0
> c02a594c r __func__.8
> c02a5960 r llc_oui
> c02a59a8 r __func__.4
> c02c6bc8 d __pci_fixup_PCI_VENDOR_ID_S3PCI_DEVICE_ID_S3_868quirk_s3_64M
> c02c6bc8 D __start_pci_fixups_header
> c02c6bd0 d __pci_fixup_PCI_VENDOR_ID_S3PCI_DEVICE_ID_S3_968quirk_s3_64M
> c02c6bd8 d __pci_fixup_PCI_VENDOR_ID_ALPCI_DEVICE_ID_AL_M7101quirk_ali7101_acpi
> c02c6be0 d __pci_fixup_PCI_VENDOR_ID_INTELPCI_DEVICE_ID_INTEL_82371AB_3quirk_piix4_acpi


-- 
~Randy
