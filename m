Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWIGQWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWIGQWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWIGQWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:22:39 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:28360 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932264AbWIGQWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:22:38 -0400
Date: Thu, 07 Sep 2006 12:21:47 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6.18-rc6] ext3 memory leak
In-reply-to: <Pine.LNX.4.63.0609071657490.1700@pcgl.dsa-ac.de>
To: linux-kernel@vger.kernel.org
Message-id: <200609071221.47574.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.63.0609071300330.1700@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0609071657490.1700@pcgl.dsa-ac.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 September 2006 11:21, Guennadi Liakhovetski wrote:
>On Thu, 7 Sep 2006, Guennadi Liakhovetski wrote:
>> I've reported before in thread "[2.6.17.4] slabinfo.buffer_head
>> increases" a memory leak in ext3. Today I verified it is still present
>> in 2.6.18-rc6.
>
>No, sorry, I cannot seem to reproduce it under -rc6. It seems to
> stabilize eventually. But it doesn't under -rc2. I looked through all
> commits to ext3 code between -rc2 and -rc6 and I don't see any obvious
> reasons why a memory leak may have been fixed. Unless somebody can sched
> some light on this, I'll try to upgrade the problematic system to -rc6
> tomorrow.
>
I just had to restart x because I was playing with keyboard layouts, trying 
to get the alt keys to properly type the 3rd level chars and screwing it 
all up, and when I had done the restart, that line in slabinfo was 
somewhat reset:
[root@coyote root]# grep buffer_head /proc/slabinfo
buffer_head        46789  78858     48   78    1 : tunables  120   60    
0 : slabdata   1011   1011      0

And frankly I don't know enough about it to state it as a fact.  Time will 
tell though.

>Just to be quite sure - this cannot (or is very unlikely to) be a libc
>bug, right?
>
>Thanks
>Guennadi
>---------------------------------
>Guennadi Liakhovetski, Ph.D.
>DSA Daten- und Systemtechnik GmbH
>Pascalstr. 28
>D-52076 Aachen
>Germany
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
