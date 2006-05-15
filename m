Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWEOWwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWEOWwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWEOWwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:52:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:59753 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750713AbWEOWwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:52:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FidsPXKyXgaQFRGDZvSlnxjcGbS9+4CZbFMaP/kPdBflItth0fZ70psAUAr6iRNqRO4a9+dNkAMbwRACY/aqZxB0WaPqesmKA4QjGcCYJQS2K5Syu/Xe+VxGUi2oK38ukol0SQx/8J+ijZOHHEYdXDkSqLqUDMKE79Dxn8vC7pg=
Message-ID: <44690640.2000407@gmail.com>
Date: Tue, 16 May 2006 07:52:48 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org> <4468C33F.7070905@garzik.org> <4468D777.6080408@rtr.ca>
In-Reply-To: <4468D777.6080408@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Andrew Morton wrote:
> ..
>>> http://bugzilla.kernel.org/show_bug.cgi?id=5586
>>
>> sata_mv still considered highly experimental, as noted in Kconfig.  
>> Bugs deferred to Mark Lord.
> ..
> I think that particular bug has gone away with my internal sata_mv.c 
> version.
> I'm updating it for release on top of Jeff/Tejun's patch set, and will 
> likely
> backport the bugfixes to 2.6.16.xx as well.  Timeline, this week or next.

The hotplug patches will change probing once more.  So, I recommend 
staying with legacy ->phy_reset mechanism for the time being unless you 
are using ->probe_reset() already.  However, converting from 
->probe_reset() to hotplug should be very easy.

-- 
tejun
