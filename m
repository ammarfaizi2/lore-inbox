Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUGZUf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUGZUf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUGZUf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:35:56 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:26284 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265175AbUGZUCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:02:21 -0400
Message-ID: <4105633C.3080204@xeon2.local.here>
Date: Mon, 26 Jul 2004 22:02:04 +0200
From: kladit@t-online.de (Klaus Dittrich)
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Klaus Dittrich <kladit@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
References: <20040726150615.GA1119@xeon2.local.here> <20040726123702.222ae654.akpm@osdl.org>
In-Reply-To: <20040726123702.222ae654.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: JbGEtwZFoeRICELTdk9d6d24Ri115lePGQOS2XjxLeXW-kMjKfwEr8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>kladit@t-online.de (Klaus Dittrich) wrote:
>  
>
>>>Can you narrow the onset of the problem down to any particular kernel
>>>      
>>>
>> >snapshot?
>>
>> Did it and here is the answer.
>>
>> kernel-2.6.7 and bk's up to 2.6.7-bk7 survived a du -s,
>> kernels starting with 2.6.7-bk8 did not.
>>    
>>
>
>Dammit, -bk7 to -bk8 is a 1.8M diff.  Relevant changes include the switch
>to the rcu callbacks (make them take an rcu_head* rather than a void*) and
>the introduction of /proc/sys/vm/vfs_cache_pressure.
>
>So the immediate question is: please check the contents of your
>vfs_cache_pressure tunable.  It should be 100.  A setting of zero would
>cause this behaviour.
>
>  
>
>> Compiler gcc-3.4.1 
>>    
>>
>
>It would be useful to try a different compiler version.
>
>There's _something_ different in your setup.  If we can work out what this
>factor is, it will lead us to the bug.
>
>  
>

cat /proc/sys/vm/vfs_cache_pressure shows 100.
Should I try an older or newer compiler ?

