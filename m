Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVDVR4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVDVR4p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVDVR4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:56:45 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:33488 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262091AbVDVR4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:56:24 -0400
Message-ID: <42693A8A.80105@ammasso.com>
Date: Fri, 22 Apr 2005 12:55:22 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Roland Dreier <roland@topspin.com>, Troy Benjegerdes <hozer@hozed.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	 <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>	 <4263DBBF.9040801@ammasso.com> <1113840973.6274.84.camel@laptopd505.fenrus.org>
In-Reply-To: <1113840973.6274.84.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2005-04-18 at 11:09 -0500, Timur Tabi wrote:
> 
>>Roland Dreier wrote:
>>
>>>    Troy> How is memory pinning handled? (I haven't had time to read
>>>    Troy> all the code, so please excuse my ignorance of something
>>>    Troy> obvious).
>>>
>>>The userspace library calls mlock() and then the kernel does
>>>get_user_pages().
>>
>>Why do you call mlock() and get_user_pages()?  In our code, we only call mlock(), and the 
>>memory is pinned. 
> 
> 
> this is a myth; linux is free to move the page about in physical memory
> even if it's mlock()ed!!

Can you tell me when Linux actually does this?  I know in theory it can happen, but I've 
never seen it.  Does the code to implement moving of data from one physical page to 
another even exist in any version of Linux?

Also, what would be the point?  What reason would there be to move some data from one 
physical page to another, while keeping the same virtual address?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
