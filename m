Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWDZJxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWDZJxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWDZJxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:53:04 -0400
Received: from [84.204.75.166] ([84.204.75.166]:14305 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1751410AbWDZJxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:53:02 -0400
Message-ID: <444F42FC.8020306@oktetlabs.ru>
Date: Wed, 26 Apr 2006 13:53:00 +0400
From: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: David Teigland <teigland@redhat.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] GFS2: Mounting & sysfs interface
References: <1145636505.3856.116.camel@quoit.chygwyn.com> <444E53FC.5060100@oktetlabs.ru> <20060425180433.GA17525@redhat.com>
In-Reply-To: <20060425180433.GA17525@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland wrote:
> On Tue, Apr 25, 2006 at 08:53:16PM +0400, Artem B. Bityutskiy wrote:
> 
>>Hello,
>>
>>last time I tried to use "bare" sysfs functions to create my sysfs 
>>hierarchy I ended up with a problem that the module refcount is not 
>>increased when those sysfs files are opened. So I could open a sysfs 
>>file from userspace, do rmmod and enjoy oops.
>>
>>Then I started using the class and class_device stuff, which have an 
>>.owner field, and all became fine.
>>
>>I'm not sure if this is a problem of sysfs, but I suspect it could take 
>>care of module refcount better.
>>
>>In your patch, I looked for THIS_MODULE pattern and did not find. I did 
>>not try, but I suspect your code is not devoid of the problem I 
>>described. So, this is just FYI and may be not the case.
> 
> 
> Others have also alluded to /sys/fs/ races that we'll probably need to
> resolve.  In this case the question is more about umount than rmmod since
> the mount should reference the module.
Right. I just thought you expose sysfs files even if you're not mounted. 
Sorry, I did not dig deeply.

-- 
Best regards, Artem B. Bityutskiy
Oktet Labs (St. Petersburg), Software Engineer.
+7 812 4286709 (office) +7 911 2449030 (mobile)
E-mail: dedekind@oktetlabs.ru, Web: www.oktetlabs.ru
