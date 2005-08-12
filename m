Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVHLVad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVHLVad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVHLVad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:30:33 -0400
Received: from mail.dvmed.net ([216.237.124.58]:10157 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750901AbVHLVac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:30:32 -0400
Message-ID: <42FD14F0.5030500@pobox.com>
Date: Fri, 12 Aug 2005 17:30:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.12.3] PCI/libata INTx cleanup
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com>
In-Reply-To: <20050812171043.CF61020E8B@lns1058.lss.emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Jeff Garzik wrote:

>>Though there is nothing wrong with this patch, I would prefer a single 
>>function, pci_intx(), as found in drivers/scsi/ahci.c.

> Sounds like what I did, except for the naming change.  I did away with
> pci_disable_intx() and changed the names.  Look ok?


Nope.

<thinks, and checks something>  Ahhhhh.  You were looking at an older 
kernel.Nope.  Read the implementation I referenced, in ahci.c, from 
2.6.13-rc6.  It takes a second argument:

	static void pci_intx(struct pci_dev *pdev, int enable)

Regards,

	Jeff


