Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSKBX02>; Sat, 2 Nov 2002 18:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbSKBX02>; Sat, 2 Nov 2002 18:26:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42762 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261509AbSKBX0Y>;
	Sat, 2 Nov 2002 18:26:24 -0500
Message-ID: <3DC4604D.4050006@pobox.com>
Date: Sat, 02 Nov 2002 18:31:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Dave Jones <davej@codemonkey.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [announce] swap mini-howto
References: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net> <20021102000907.GA9229@suse.de> <3DC3207A.450402B3@zip.com.au> <3DC38C43.6020103@pobox.com> <3DC3A2AD.69775F06@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>That got stamped out.  swapon will fail if the file isn't fully
>instantiated on disk:
>
>
>static int setup_swap_extents(struct swap_info_struct *sis)
>{
>	...
>                        block = bmap(inode, probe_block + block_in_page);
>                        if (block == 0)
>                                goto bad_bmap;
>	...
>
>bad_bmap:
>        printk(KERN_ERR "swapon: swapfile has holes\n");
>        ret = -EINVAL;
>}
>  
>

I am in further awe of you.

    Jeff





