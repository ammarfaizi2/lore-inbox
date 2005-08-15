Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVHOTRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVHOTRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 15:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVHOTRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 15:17:12 -0400
Received: from mail.dvmed.net ([216.237.124.58]:16571 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964891AbVHOTRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 15:17:11 -0400
Message-ID: <4300EA2E.4010303@pobox.com>
Date: Mon, 15 Aug 2005 15:17:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc6] PCI/libata INTx cleanup
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com>
In-Reply-To: <20050815185732.GA15216@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Aug 12, 2005 at 06:43:03PM -0400, Brett Russ wrote:
> 
>>Simple cleanup to eliminate X copies of the pci_enable_intx() function
>>in libata.  Moved ahci.c's pci_intx() to pci.c and use it throughout
>>libata and msi.c.
>>
>>Signed-off-by: Brett Russ <russb@emc.com>
> 
> 
> It would have been nice if you had built this code :(
> 
> Hint, get rid of all TRUE and FALSE usages in your patch.  Care to try
> again?

just manually s/TRUE/1/ and s/FALSE/0/ in the patch...

I could have sworn TRUE and FALSE were in linux/kernel.h, but it looks 
like I was wrong.

	Jeff



