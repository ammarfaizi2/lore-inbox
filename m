Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUIASIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUIASIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUIASFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:05:55 -0400
Received: from mail.tmr.com ([216.238.38.203]:50441 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266892AbUIASF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:05:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Date: Wed, 01 Sep 2004 14:06:16 -0400
Organization: TMR Associates, Inc
Message-ID: <ch52km$grt$1@gatekeeper.tmr.com>
References: <20040901072245.GF13749@mellanox.co.il><20040901072245.GF13749@mellanox.co.il> <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1094061526 17277 192.168.12.100 (1 Sep 2004 17:58:46 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Sep 01, 2004 at 10:22:45AM +0300, Michael S. Tsirkin wrote:
> 
>>Hello!
>>Currently, on the x86_64 architecture, its quite tricky to make
>>a char device ioctl work for an x86 executables.
>>In particular,
>>   1. there is a requirement that ioctl number is unique -
>>      which is hard to guarantee especially for out of kernel modules
> 
> 
> Too bad.
> 
> 
>>   2. there's a performance huge overhead for each compat call - there's
>>      a hash lookup in a global hash inside a lock_kernel -
>>      and I think compat performance *is* important.
>>
>>Further, adding a command to the ioctl suddenly requires changing
>>two places - registration code and ioctl itself.
> 
> 
> So don't add them.  Adding a new ioctl is *NOT* a step to be taken lightly -
> we used to be far too accepting in that area and as somebody who'd waded
> through the resulting dungpiles over the last months I can tell you that
> result is utterly revolting.
> 
> Excuse me, but I have zero sympathy to people who complain about obstacles
> to dumping more into the same piles - it should be hard.

I don't think he was complaining so much as providing a rationale for 
the patch he offered which is intended to make things better. Seemed to 
me like a good context for the patch.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
