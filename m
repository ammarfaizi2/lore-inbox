Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVIOCNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVIOCNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVIOCNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:13:38 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:6651 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030342AbVIOCNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:13:38 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Robert Love <rml@novell.com>
Cc: Mike Bell <mike@mikebell.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>
X-X-Sender: dlang@dlang.diginsite.com
Date: Wed, 14 Sep 2005 19:13:27 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: devfs vs udev FAQ from the other side
In-Reply-To: <1126746518.9652.60.camel@phantasy>
Message-ID: <Pine.LNX.4.62.0509141911530.8469@qynat.qvtvafvgr.pbz>
References: <20050915005105.GD15017@mikebell.org> <1126746518.9652.60.camel@phantasy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Robert Love wrote:

>>   Took an actual devfs system of mine and disabled devfs from the
>>   kernel, then enabled hotplug and sysfs for udev to run.  make clean
>>   and surprise surprise, kernel is much bigger. Enable netlink stuff and
>>   it's bigger still. udev is only smaller if like Greg you don't count
>>   its kernel components against it, even if they wouldn't otherwise need
>>   to be enabled. Difference is to the tune of 604164 on udev and 588466
>>   on devfs. Maybe not a lot in some people's books, but a huge
>>   difference from the claims of other people that devfs is actually
>>   bigger.
>
> What modern system, though, could survive without hotplug and sysfs and
> netlink?  You need to have those components, you want those features,
> anyhow.

most servers and embedded systems can survive just fine without hotplug 
(in fact hotplug is frequently the slowest part of the boot).

sysfs and netlink I would have to think about, I know I don't expliticitly 
use either very much, but I'd have to check to see what may use them that 
I don't think about.

David Lang

> So your comparison is unrealistic.
>
> Your user-space argument is better.  Is ndevfs not sufficient?
>
> 	Robert Love
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
