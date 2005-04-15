Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVDOST0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVDOST0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVDOSST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:18:19 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:12466 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261905AbVDOSQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:16:09 -0400
Message-ID: <426004E5.8030806@ammasso.com>
Date: Fri, 15 Apr 2005 13:16:05 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Igor Shmukler <igor.shmukler@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
References: <6533c1c905041511041b846967@mail.gmail.com>
In-Reply-To: <6533c1c905041511041b846967@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Shmukler wrote:
> Hello,
> We are working on a LKM for the 2.6 kernel.
> We HAVE to intercept system calls. I understand this could be
> something developers are no encouraged to do these days, but we need
> this.

Too bad.

> Patching kernel to export sys_call_table is not an option. The fast
> and dirty way to do this would be by using System.map, but I would
> rather we find a cleaner approach.

There is none.  And even System.map can be unreliable.  Some distros/kernels only include 
exported symbols in System.map, and sys_call_table is not exported in 2.6.

> I did some research on google and I know this issue has been raised
> before, but unfortunately I could not find a coherent answer.
> Does anyone know of any tutorial or open source code where I could
> look at how this is done? I think that IDT should give me the entry
> point, but where do I get system call table address?

You don't.

You're just going to have to accept that fact that what you want to do, the way you want 
to do it, is just not going to happen.  Sorry.

Your best bet is to design and implement a clean and safe mechanisming for intercepting 
system calls, and submit that to the kernel.  It will probably get rejected, but it still 
might be worth a shot.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
