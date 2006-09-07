Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWIGLbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWIGLbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWIGLbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:31:35 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:52449 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751713AbWIGLbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:31:34 -0400
Date: Thu, 07 Sep 2006 07:31:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6.18-rc6] ext3 memory leak
In-reply-to: <Pine.LNX.4.63.0609071300330.1700@pcgl.dsa-ac.de>
To: linux-kernel@vger.kernel.org
Message-id: <200609070731.19124.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.63.0609071300330.1700@pcgl.dsa-ac.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 September 2006 07:10, Guennadi Liakhovetski wrote:
>Hi all,
>
>this looks like a serious problem to be fixed before 2.6.18 final and
>backported to 2.6.17.*. Or a case of me misunderstanding something, in
>which case, please, let me know.
>
>I've reported before in thread "[2.6.17.4] slabinfo.buffer_head
> increases" a memory leak in ext3. Today I verified it is still present
> in 2.6.18-rc6.
>
>A short description: as long as write accesses are made on an ext3
>filesystem /proc/slabinfo buffer_head increases unboundedly. This
>behaviour is not observed with another journalling filesystems (e.g.,
>reiserfs), or if ext3 is mounted as ext2.
>
What would you call the 'get excited' level?  Here, with about 12 hours of 
uptime (I had an unlogged machine shutdown while I was offsite yesterday), 
I'm showing 

buffer_head        67158  67158     48   78    1 : tunables  120   60    
0 : slabdata    861    861      0

There are other entries that are larger here.  However I do note that its 
growing on a per cycle basis as fetchmail is doing its thing every 90 
seconds.  Now its
buffer_head        67672  67704     48   78    1 : tunables  120   60    
0 : slabdata    868    868      0

So perhaps thats why it did the shutdown?  With absolutely zip in the logs?

Although, my firewall box was also reset/rebooted about the same time as 
this ones powerdown according to an uptime report on it just now, so my 
ups must not be doing its thing correctly.

>As it seems serious enough to me I'm sending it to ext3 maintainers.
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
