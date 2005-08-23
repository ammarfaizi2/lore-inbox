Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVHWTwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVHWTwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVHWTwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:52:50 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:48768 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S932351AbVHWTwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:52:49 -0400
Message-ID: <430B0EAE.9080504@davyandbeth.com>
Date: Tue, 23 Aug 2005 06:55:26 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl> <430B01FB.2070903@davyandbeth.com> <20050823191254.GB10110@alpha.home.local> <430B077A.10700@davyandbeth.com> <20050823194557.GC10110@alpha.home.local>
In-Reply-To: <20050823194557.GC10110@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2005 19:52:25.0140 (UTC) FILETIME=[2F05FF40:01C5A81C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info.. I did find this thread and was wondering if this 
patch ever got put in

http://www.ussg.iu.edu/hypermail/linux/kernel/0303.3/1139.html



Willy Tarreau wrote:

>On Tue, Aug 23, 2005 at 06:24:42AM -0500, Davy Durham wrote:
>  
>
>>That's probably a good idea.  Where would I find out what other projects 
>>use it?
>>    
>>
>
>I use it in my load-balancer (haproxy), and it could somewhat match your
>needs, because I ported the select()-based earlier version to epoll() with
>the smallest possible changes. Indeed, the new epoll() loop still uses the
>FD_ISSET() to determine what to do with epoll_ctl(). If you have changed
>your code to use select(), you may find similarities. But I want to tell
>you from now that my code is NOT multi-threaded. It could be a bug in the
>epoll implementation, because I don't think that there are so many
>applications using epoll on MT models. Bert says that the epoll implementation
>is heavily benchmarked, which is true, but which does not guarantee that it
>is tested under every condition.
>
>You can download it from there :
>
>  http://w.ods.org/tools/haproxy/src/devel/
>
>Use version 1.2.6. I added epoll in 1.2.5, so the diff between 1.2.4 and
>1.2.5 could help you too.
>
>Good luck !
>Willy
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

