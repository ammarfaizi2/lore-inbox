Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293403AbSBYNRG>; Mon, 25 Feb 2002 08:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293404AbSBYNQ4>; Mon, 25 Feb 2002 08:16:56 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:11219 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S293403AbSBYNQr>;
	Mon, 25 Feb 2002 08:16:47 -0500
Message-ID: <3C7A398A.1060300@sgi.com>
Date: Mon, 25 Feb 2002 07:18:02 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@zip.com.au>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au> <3C781362.7070103@sgi.com> <3C781909.F69D8791@zip.com.au> <3C7A35FF.5040508@sgi.com> <20020225131218.GO11837@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Mon, Feb 25 2002, Stephen Lord wrote:
>
>>Andrew Morton wrote:
>>
>>>
>>>Unfortunately I seem to have found a bug in existing ext2, a bug
>>>in existing block_write_full_page, a probable bug in the aic7xxx
>>>driver, and an oops in the aic7xxx driver.  So progress has slowed
>>>down a bit :(
>>>
>>Try this for the aic driver:
>>
>
>Steve,
>
>DaveM's alternate fix has been in the 2.4 and 2.5 kernels for some time,
>so given that Andrew is testing 2.5.5 this can't be the problem.
>

OK, I was not aware that went in, thanks.

>
>
>>We hit this once bio got introduced and we maxed out the request size
>>for the driver. Justin has the  code in his next aic version.
>>
>
>Just for the record, this was/is not a bio bug, it was an aic7xxx bug
>that could trigger with or without bio.
>
Yep, bio just made it easier to get larger requests.

Steve



