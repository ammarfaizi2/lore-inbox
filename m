Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTFCArh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTFCArh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:47:37 -0400
Received: from dyn-ctb-210-9-244-45.webone.com.au ([210.9.244.45]:37637 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264432AbTFCArg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:47:36 -0400
Message-ID: <3EDBF344.7090906@cyberone.com.au>
Date: Tue, 03 Jun 2003 11:00:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.70-mm2 with contest
References: <200306030806.49885.kernel@kolivas.org>	<20030602151644.06252b28.akpm@digeo.com>	<3EDBEC27.9070705@cyberone.com.au> <20030602175410.5f198657.akpm@digeo.com>
In-Reply-To: <20030602175410.5f198657.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>  
>
>>It will be interesting to see what happens if we set the
>> ext3 journal write paths as PF_SYNCWRITE. I'll try some tests
>> a bit later today.
>>
>>    
>>
>
>OK.
>
>Longer-term it would be best to lose the PF_SYNCWRITE thing and to just
>mark the BIOs as synchronous prior to submitting them.  It's a matter of
>transferring the info in writeback_control.sync_mode at the pagecache/BIO
>boundary: mpage_bio_submit(), __block_write_full_page->submit_bh(), etc.
>  
>

Yeah that is better. Would be no problem for AS.

