Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVCOSjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVCOSjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVCOShx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:37:53 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:52241 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261735AbVCOSbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:31:46 -0500
Message-ID: <42371879.6000907@lougher.demon.co.uk>
Date: Tue, 15 Mar 2005 17:16:41 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org>	<A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org>
In-Reply-To: <20050314190140.5496221b.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
> 
>>[ on-disk bitfields ]
>>
>>I've checked compatibilty against Intel 32 and 64 bit architectures, 
>> PPC 32/64 bit, ARM, MIPS
>> and SPARC.  I've used compilers from 2.91.x upto 3.4...
> 
> 
> hm, OK.  I remain a bit skeptical but it sounds like you're the expert.  I
> guess if things later explode it will be pretty obvious, and the filesystem
> will need rework.
> 
> One thing which I assume we don't know at this stage is whether all 27
> architectures work as expected - you can bet ia64 does it differently ;)
> 
> How does one test that?  Create a filesystem-in-a-file via mksquashfs, then
> transfer that to a different box, then try and mount and use it, I assume?
> 

Yes, slow and laborious, but it works...

> When you upissue these patches, please include in the changelog pointers to
> the relevant userspace support tools - mksquashfs, fsck.squashfs, etc.  I
> guess http://squashfs.sourceforge.net/ will suit.
> 

OK.

> Also, this filesystem seems to do the same thing as cramfs.  We'd need to
> understand in some detail what advantages squashfs has over cramfs to
> justify merging it.  Again, that is something which is appropriate to the
> changelog for patch 1/1.
> 

OK.  Squashfs has much better compression and is much faster than 
cramfs, which is why many embedded systems that used cramfs have moved 
over to squashfs.  Additionally squashfs is used in liveCDs (where 
cramfs can't be used because of its max 256MB size limit), where it is 
slowly taking over from cloop, again because it compresses better and is 
faster.

Both these two groups have been asking for squashfs to be in the 
mainline kernel.

I can put the above rationale and a pointer to some performance 
statistics in the changelog, will that be sufficient?

Phillip
