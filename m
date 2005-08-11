Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVHKTBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVHKTBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVHKTBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:01:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39335 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932367AbVHKTBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:01:38 -0400
Message-ID: <42FBA08C.5040103@pobox.com>
Date: Thu, 11 Aug 2005 15:01:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.12.3] PCI/libata INTx cleanup
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com>
In-Reply-To: <20050803204709.8BA0720B06@lns1058.lss.emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Simple cleanup to eliminate X copies of the same function in libata.  
> Moved pci_enable_intx() to pci.c, added pci_disable_intx() as well, 
> and use them throughout libata and msi.c.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

Though there is nothing wrong with this patch, I would prefer a single 
function, pci_intx(), as found in drivers/scsi/ahci.c.

Would you be willing to move that one to the PCI layer, eliminate the 
multiple copies of pci_enable_intx(), and replace the calls to 
pci_enable_intx() with calls to pci_intx() ?

	Jeff


