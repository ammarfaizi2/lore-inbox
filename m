Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275342AbTHGNY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275344AbTHGNY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:24:56 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:3327 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S275342AbTHGNYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:24:51 -0400
Message-ID: <3F32531B.7080000@namesys.com>
Date: Thu, 07 Aug 2003 17:24:43 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] reiserfs: fix locking in reiserfs_remount
References: <20030806093858.GF14457@namesys.com> <20030806172813.GB21290@matchmail.com> <20030806173114.GB15024@namesys.com>
In-Reply-To: <20030806173114.GB15024@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hello!
>
>On Wed, Aug 06, 2003 at 10:28:13AM -0700, Mike Fedyk wrote:
>  
>
>>>    Since reiserfs_remount can be called without BKL held, we better take BKL in there.
>>>    Please apply the below patch. It is against 2.6.0-test2
>>>      
>>>
>>is the BKL in reiserfs_write_unlock()?
>>    
>>
>
>Yes.
>
>  
>
>>Do we need to be adding more BKL usage, instead of the same or less at this
>>point?
>>    
>>
>
>Reiserfs needs BKL for it's journal operations. This is not "more",
>for some time BKL was taken in the VFS, then whoever removed that,
>forgot to propagate BKL down to actual fs methods that need the BKL.
>
>Bye,
>    Oleg
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Is it known who removed it?

-- 
Hans


