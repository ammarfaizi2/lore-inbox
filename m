Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVHLVmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVHLVmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVHLVmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:42:38 -0400
Received: from quark.didntduck.org ([69.55.226.66]:30090 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751291AbVHLVmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:42:37 -0400
Message-ID: <42FD1828.6030003@didntduck.org>
Date: Fri, 12 Aug 2005 17:44:08 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Brett Russ <russb@emc.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12.3] PCI/libata INTx cleanup
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de>
In-Reply-To: <20050812182253.GA7842@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Aug 12, 2005 at 01:10:43PM -0400, Brett Russ wrote:
> 
>>Jeff Garzik wrote:
>>
>>>Brett Russ wrote:
>>>
>>>
>>>>Simple cleanup to eliminate X copies of the same function in libata.  
>>>>Moved pci_enable_intx() to pci.c, added pci_disable_intx() as well, 
>>>>and use them throughout libata and msi.c.
>>>>
>>>>Signed-off-by: Brett Russ <russb@emc.com>
>>>
>>>
>>>Though there is nothing wrong with this patch, I would prefer a single 
>>>function, pci_intx(), as found in drivers/scsi/ahci.c.
>>>
>>>Would you be willing to move that one to the PCI layer, eliminate the 
>>>multiple copies of pci_enable_intx(), and replace the calls to 
>>>pci_enable_intx() with calls to pci_intx() ?
>>
>>Sounds like what I did, except for the naming change.  I did away with
>>pci_disable_intx() and changed the names.  Look ok?
> 
> 
> Looks ok to me, care to resend it with a Signed-off-by: and a new
> changelog entry so I can apply it?
> 
> 
>>+EXPORT_SYMBOL(pci_intx);
> 
> 
> Hm, for new pci functions, I prefer to have them marked as
> EXPORT_SYMBOL_GPL(), is that ok with you?

It's not really "new".  It's simply a trivial wrapper around other pci 
functions.

--
				Brian Gerst
