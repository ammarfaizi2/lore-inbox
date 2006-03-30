Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWC3Smd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWC3Smd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWC3Smd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:42:33 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:31919 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750700AbWC3Smd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:42:33 -0500
Message-ID: <442C268F.7080701@us.ibm.com>
Date: Thu, 30 Mar 2006 10:42:23 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       lkml <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: kernel BUG at fs/direct-io.c:916!
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de> <20060327080811.D753448@wobbly.melbourne.sgi.com> <20060326230358.GG4776@charite.de> <20060327060436.GC2481@frodo> <20060327110342.GX21946@charite.de> <20060328050135.GA2177@frodo> <1143567049.26106.2.camel@dyn9047017100.beaverton.ibm.com> <20060329082345.G871924@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nathan Scott wrote:

>On Tue, Mar 28, 2006 at 09:30:44AM -0800, Badari Pulavarty wrote:
>
>>Thanks for working this out. You may want to add a description
>>to the patch. Like:
>>
>>"inode->i_blkbits should be used instead of dio->blkbits, as
>>it may not indicate the filesystem block size all the time".
>>
>
>Will do, thanks.  Oh, another thing - what is the situation
>where a NULL bdev would be passed into __blockdev_direct_IO?
>All the filesystems seem to pass i_sb->s_bdev, so I guess it
>must be blkdev_direct_IO - can I_BDEV(inode) ever be NULL on
>a block device inode (doesn't sound right)?  If it cannot, I
>suppose we should remove those NULL bdev checks too...
>
>cheers.
>

I can't think of a case, where we would end up getting b_dev = NULL in 
direct
IO code.

Thanks,
Badari

>
>



