Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751950AbWCBDNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWCBDNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWCBDNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:13:48 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:8176 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751950AbWCBDNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:13:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lIrWTyzxh/ePZ0r/UZYbEBbPacTLJgHOzWShZhCDhDiGnTn2BMZssArnq0+0nZ0VsHTqMX9AJ9UIb6fA+yw95+80dwLlHZrQRdOW4TbF5ZVpbc3V2M0gnEqmNIURjnFM2na2LL7Lp0sq56qUz7kK5oDUZNjTDbtW7yRMVVVWkL4=
Message-ID: <440662E4.4090109@gmail.com>
Date: Thu, 02 Mar 2006 12:13:40 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "Eric D. Mudama" <edmudama@gmail.com>, Jens Axboe <axboe@suse.de>,
       Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org>	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>	 <44065C7C.6090509@pobox.com> <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com> <44066132.4010205@pobox.com>
In-Reply-To: <44066132.4010205@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Eric D. Mudama wrote:
> 
>> The "failing dmesg" has the plextor connected to sata_nv, and the two
>> Maxtor drives connected to sata_sil, if I read it correctly.  They're
>> ata5/ata6 ports, mapped as sda/sdb.
>>
>> Nicolas' comment in the thread "Re: LibPATA code issues / 2.6.15.4"
>> seemed to say it was the same adapter:
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=114123989405668&w=2
> 
> 
> Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is the 
> way to go...
> 

Agreed. I'm currently implementing VDMA on sata_sil and will get to FUA 
via explicit protocol soon.

-- 
tejun
