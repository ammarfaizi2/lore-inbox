Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313265AbSDDQww>; Thu, 4 Apr 2002 11:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313267AbSDDQwm>; Thu, 4 Apr 2002 11:52:42 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28676 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313265AbSDDQwc>; Thu, 4 Apr 2002 11:52:32 -0500
Message-ID: <3CAC764C.2010404@evision-ventures.com>
Date: Thu, 04 Apr 2002 17:50:36 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1 fs/dquot
In-Reply-To: <Pine.GSO.4.21.0204041142240.22660-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 4 Apr 2002, Martin Dalecki wrote:
> 
> 
>>Looking further through the pre patch I have found the following:
>>
>>diff -Nru a/fs/dquot.c b/fs/dquot.c
>>--- a/fs/dquot.c	Wed Apr  3 17:11:14 2002
>>+++ b/fs/dquot.c	Wed Apr  3 17:11:14 2002
>>...
>>+static ctl_table fs_table[] = {
>>+ 
>>{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
>>+ 
>>  0444, NULL, &proc_dointvec},
>>+ 
>>{},
>>+};
>>
>>
>>What the heck is "dquot-nr"?
> 
> 
> The name that used to be there in 2.5.7 and before.  Check kernel/sysctl.c -
> this stuff had been moved from there verbatim.

Yes of course. My point is: Those names are unsystematical and
ugly *alltogether*. However it's of course not worth the effort to
change them right now...


