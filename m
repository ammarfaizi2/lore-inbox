Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265381AbSKBIVB>; Sat, 2 Nov 2002 03:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265893AbSKBIVB>; Sat, 2 Nov 2002 03:21:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265381AbSKBIVA>;
	Sat, 2 Nov 2002 03:21:00 -0500
Message-ID: <3DC38C43.6020103@pobox.com>
Date: Sat, 02 Nov 2002 03:26:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Dave Jones <davej@codemonkey.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [announce] swap mini-howto
References: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net> <20021102000907.GA9229@suse.de> <3DC3207A.450402B3@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Something I'd like to point out here:  in 2.4 and earlier, swapfiles
>are less robust than swap devices - the need to go and read metadata
>from the filesystem made them prone to oom deadlocks allocating pages
>and buffer_heads with which to perform the swapout.
>
>That has changed in 2.5.  Swapping onto a regular file has no
>disadvantage wrt swapping onto a block device.  The kernel does
>not need to allocate any memory at all to get a swapcache page
>onto disk.
>
>Which is interesting.  Because swapfiles are much easier to administer,
>and much easier to stripe.  Adding, removing and resizing is simplified.
>Distributors of 2.6-based kernels could consider doing away with
>swapdevs altogether.
>  
>

That said, I would like to again point out that using sparse swapfiles 
should still be discouraged.  It may be supported, but it's much better 
for system performance and stability, IMO, if the sysadmin makes certain 
all swapfiles are 100% allocated before they are mentioned to the swap 
subsystem.

    Jeff




