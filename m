Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWBYBmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWBYBmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 20:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWBYBmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 20:42:11 -0500
Received: from physics.harvard.edu ([128.103.101.20]:17083 "EHLO
	physics.harvard.edu") by vger.kernel.org with ESMTP id S964841AbWBYBmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 20:42:10 -0500
Message-ID: <43FFB5F0.5020001@physics.harvard.edu>
Date: Fri, 24 Feb 2006 20:42:08 -0500
From: Milan Kupcevic <milan@physics.harvard.edu>
Organization: Harvard University
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       torvalds@osdl.org
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4,
 SATA 300 TX4
References: <43FFAE3D.7010002@physics.harvard.edu> <43FFB009.6070403@pobox.com>
In-Reply-To: <43FFB009.6070403@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Milan Kupcevic wrote:
>
>> From: Milan Kupcevic <milan@physics.harvard.edu>
>>
>> Fix Promise SATAII 150 TX4 (PDC40518) and Promise SATA 300 TX4 
>> (PDC40718-GP) wrong port enumeration order that makes it (nearly) 
>> impossible to deal with boot problems using two or more drives.
>>
>> Signed-off-by: Milan Kupcevic <milan@physics.harvard.edu>
>> ---
>>
>> The current kernel driver assumes:
>>
>> port 1 - scsi3
>> port 2 - scsi1
>> port 3 - scsi0
>> port 4 - scsi2
>
>
> The current kernel driver assumes nothing, but simply exports what the 
> hardware gives us.
>
> It sounds like you are trying to patch the kernel because you received 
> an incorrectly-wired board.  NAK.
>
>     Jeff
>

I have tested two SATAII150TX4 (chip PDC40518 id: 105a:3d18 (rev 02)) 
adapters and one SATA300TX4 (chip PDC40718-GP id: 105a:3d17 (rev 02)) 
adapter on three different boards in last several days with exactly the 
same results.

The problem disappears when using the driver form the www.promise.com site.

BIOS, Grub and promise.com driver agree the printed and documented port 
order is correct but the current kernel driver exports (wrong) 3-2-4-1 
port order.


Thanks,

Milan

-- 
Milan Kupcevic
System Administrator
Harvard University
Department of Physics

