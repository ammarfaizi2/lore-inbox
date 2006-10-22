Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWJVSzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWJVSzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWJVSzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:55:41 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:31924 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1750834AbWJVSzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:55:40 -0400
Message-ID: <453BBEA6.7050402@qumranet.com>
Date: Sun, 22 Oct 2006 20:55:34 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Christoph Hellwig <hch@infradead.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <200610222036.03455.arnd@arndb.de> <453BBB41.4070905@qumranet.com> <200610222049.36338.arnd@arndb.de>
In-Reply-To: <200610222049.36338.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 18:55:39.0956 (UTC) FILETIME=[AAEFE740:01C6F60B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Sunday 22 October 2006 20:41, Avi Kivity wrote:
>   
>>> Ok, but if you radically change the kernel<->user API, doesn't that mean
>>> you have to upgrade in the same way?
>>>       
>> No, why? I'd just upgrade the userspace.  Am I misunderstanding you?
>>     
>
> If you change the kernel interface, you also have to change the kernel
> itself, at least if you introduce new syscalls.
>
>   

But I don't have to upgrade all my software to 64 bit [but 32-bit 
emulation solves that].

Still, an upgrade to the next 32-bit kernel could be seen as less 
threatening.


>>> The 32 bit emulation mode in x86_64
>>> is actually pretty complete, so it probably boils down to a kernel
>>> upgrade for you, without having to touch any of the user space.
>>>  
>>>       
>> For me personally, I don't mind.  I don't know about others.
>>     
>
> I'd really love to see your code in get into the mainline kernel,
> but I'd consider 32 bit host support an unnecessary burden for
> long-term maintenance. Maybe you could maintain the 32 bit version
> out of tree as long as there is still interest? I would expect that
> at least the point where it works out of the box on x86_64
> distros is when it becomes completely obsolete.
>   

One of my motivations was to get testers who run 32-bit for historical 
or flash plugin reasons.

If there is a consensus that it should be dropped, though, I'll drop 
it.  I certainly didn't have any fun getting it to run.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

