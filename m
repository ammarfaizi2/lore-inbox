Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbULQShS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbULQShS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbULQSg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:36:57 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:2691 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262107AbULQSgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:36:47 -0500
Message-ID: <41C3275C.2010505@tmr.com>
Date: Fri, 17 Dec 2004 13:37:16 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: James Morris <jmorris@redhat.com>, Patrick McHardy <kaber@trash.net>,
       Bryan Fulton <bryan@coverity.com>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
References: <41C2FF99.3020908@tmr.com><Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com> <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Fri, 17 Dec 2004, Bill Davidsen wrote:
> 
>> James Morris wrote:
>>
>>> On Fri, 17 Dec 2004, Patrick McHardy wrote:
>>>
>>>
>>>> James Morris wrote:
>>>>
>>>>
>>>>> This at least needs CAP_NET_ADMIN.
>>>>>
>>>>
>>>> It is already checked in do_ip6t_set_ctl(). Otherwise anyone could
>>>> replace iptables rules :)
>>>
>>>
>>>
>>> That's what I meant, you need the capability to do anything bad :-)
>>
>>
>> Are you saying that processes with capability don't make mistakes? 
>> This isn't a bug related to untrusted users doing privileged 
>> operations, it's a case of using unchecked user data.
>>
> 
> But isn't there always the possibility of "unchecked user data"?
> I can, as root, do `cp /dev/zero /dev/mem` and have the most
> spectacular crask you've evet seen. I can even make my file-
> systems unrecoverable.

But that's not the type of thing you would do by accident. The kernel 
can't protect against deliberate abuse by trusted users, nor should it. 
But the type of problem caused by an application program bug can, and I 
believe should, be caught.

The difference between "oops" and "take that!"

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
