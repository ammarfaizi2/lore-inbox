Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVFIWsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVFIWsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFIWsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:48:53 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:34066 "EHLO
	MMS1.broadcom.com") by vger.kernel.org with ESMTP id S261412AbVFIWsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:48:50 -0400
X-Server-Uuid: 146C3151-C1DE-4F71-9D02-C3BE503878DD
Message-ID: <42A8C73C.6060005@broadcom.com>
Date: Thu, 09 Jun 2005 15:48:28 -0700
From: "Narendra Sankar" <nsankar@broadcom.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
cc: gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] Another PCI fix for 2.6.12-rc6
References: <20050609222033.GA12580@kroah.com>
 <20050609.153254.74562706.davem@davemloft.net>
In-Reply-To: <20050609.153254.74562706.davem@davemloft.net>
X-WSS-ID: 6EB618CF2V0129143-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>From: Greg KH <gregkh@suse.de>
>Date: Thu, 9 Jun 2005 15:20:33 -0700
>
>  
>
>>	"Broadcom already submitted the bnx2 driver for the 5706 gigabit
>>	driver which enables MSI on all systems that support PCI-X. That
>>	patch has already gone into 2.6.12-rc6. So if the MSI disable
>>	patch does not get into 2.6.12, anyone who uses the 5706 on the
>>	Serverworks chipset platform, will have interrupt failures."
>>    
>>
>
>The bnx2 driver can get the MSI test added to it just like the tg3
>driver does.  I don't see why the same code wasn't propagated.  Either
>both drivers need that MSI test code, or both do not.
>
>That doesn't make any sense, one testing for correct MSI functionality
>while the other does not.
>
>
>  
>
Hi everyone

The platform quirk is valid for other PCI-X devices that try to enable 
MSI on that Serverworks chipset. When I submitted the msi quirk patch, 
the bnx2 driver did not have the msi check. I guess it got added. 
Different parts of the organization :(.

However the fact that MSI functionality on the GC_LE is broken could 
potentially cause problems with other devices that try to enable MSI. 
This is the only version of the chipset that the functionality is broken 
on. Other variants have working MSI implementations.

So it would still be useful to have this patch in, would it not?

Thanks
Naren Sankar
Broadcom/Serverworks.

