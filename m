Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWBOCFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWBOCFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBOCFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:05:07 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:9911 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932072AbWBOCFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:05:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bbNLznwzYOywFA7pReyqx1KDarLzuWW9ZoWLCf1u3DDEeN39uxNWqyzhhvspmh6kf8QshTnUmXsurL84agy8uG1gwj3a9GqDGLhgWNex4vCNAyxXIiAQjYxnLTjMPUS5ejxIvTBt4L7J8K5FUHwBgy2uVWB1oODphQvgwSLBBP4=
Message-ID: <43F28C4E.1090104@gmail.com>
Date: Wed, 15 Feb 2006 11:05:02 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Reimer <mattjreimer@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] block: convert IDE to use blk_kmap helpers
References: <11371658562541-git-send-email-htejun@gmail.com>	 <1137165856390-git-send-email-htejun@gmail.com> <f383264b0602141107v78864d7bua38fbaeefafd5@mail.gmail.com>
In-Reply-To: <f383264b0602141107v78864d7bua38fbaeefafd5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reimer wrote:
> On 1/13/06, Tejun Heo <htejun@gmail.com> wrote:
> 
>>Convert direct uses of kmap/unmap to blk_kmap/unmap in IDE.  This
>>combined with the previous bio helper change fixes PIO cache coherency
>>bugs on architectures with aliased caches.
>>
>>Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> This series of patches makes booting from CF on my PXA255 device. Thanks Tejun.
> 
> Will these patches make 2.6.16?
> 

Unfortunately, this patchset has some pending issues and probably should 
be spinned one more time with another approach, although I'm currently 
not very sure what the another approach should be.  :-(

I'll try to do something.  Thanks.

-- 
tejun
