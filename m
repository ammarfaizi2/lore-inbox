Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264651AbSJ3KYF>; Wed, 30 Oct 2002 05:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSJ3KYE>; Wed, 30 Oct 2002 05:24:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22534 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264651AbSJ3KYD>;
	Wed, 30 Oct 2002 05:24:03 -0500
Message-ID: <3DBFB4A5.2050201@pobox.com>
Date: Wed, 30 Oct 2002 05:29:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dcinege@psychosis.com
CC: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org> <200210300322.17933.dcinege@psychosis.com> <20021030085149.GA7919@codepoet.org> <200210300455.21691.dcinege@psychosis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege wrote:

>On Wednesday 30 October 2002 3:51, Erik Andersen wrote:
>
>Erik,
>
>  
>
>>Both formats are simple.  But cpio is simpler.
>>    
>>
>
>untar runs about 5K...same as 'un-cpio'. No differece there.
>
Wrong.  un-cpio is obviously smaller.  Just look at the generated 
assembly... on any platform.

>But not from userland. Tar is used en masse, cpio isn't.
>It's the only reason to use tar over cpio...I feel it's a
>good one.
>
IOW you'd rather bloat the kernel because tarballs are popular...

>#1 I'll be reviewing initramfs and adding loading images from
>
>the kernel support. I don't deny it's a good thing to have.
>

There is no need to add anything.

>My patch is the best of both because, it re-writes initrd
>properly within a sane framework. (Not to mention I scrubed the hell
>out of do_mounts.)
>
No need for this, initramfs means that initrd and do_mounts are moved 
out of the kernel.

>If you want to get rid of all the backwards compatible stuff
>(IE identifing and loading raw images to /dev/ram0,
>pivoting to /initrd) that's fine with me. The code is layed out now
>so I can litterally cut it out 10K of that junk in 30 seconds.
>Better yet I can ifdef it for the poor souls that still need it.
>  
>

Or better yet use initramfs, where it simply doesn't exist in the kernel 
image at all :)

    Jeff





