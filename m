Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUCIKQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 05:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUCIKQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 05:16:10 -0500
Received: from mx13.mail.ru ([194.67.23.56]:53254 "EHLO mx13.mail.ru")
	by vger.kernel.org with ESMTP id S261832AbUCIKQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 05:16:07 -0500
Message-ID: <404D9966.6080903@mail.ru>
Date: Tue, 09 Mar 2004 14:16:06 +0400
From: rihad <rihad@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.6) Gecko/20040303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel-digest@lists.us.dell.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 021 release
References: <20040303153403.21649.81059.Mailman@linux.us.dell.com> <4048D503.10808@mail.ru> <20040309081948.GI22057@kroah.com>
In-Reply-To: <20040309081948.GI22057@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Mar 05, 2004 at 11:29:07PM +0400, rihad wrote:
> 
>>Date: 	Wed, 3 Mar 2004 07:14:33 -0800
>>From: Greg KH <greg@kroah.com>
>>
>>>Users need to learn that the kernel is changing models from one which
>>>automatically loaded modules when userspace tried to access the device,
>>>to one where the proper modules are loaded when the hardware is found.
>>
>>Does this mean that I will have modules for all my hardware hanging 
>>around even if I'm not, say, using cdrom at the moment?
> 
> 
> Yup, why not?
> 

I suspect there's nothing wrong with that under many common scenarios 
(apart from the one thing I seem to dislike so much that if a cdrom 
isn't being used, no driver for it should be loaded). But it does impose 
certain amount of strict policy that Unix (and Linux more so) has long 
been doing a great job of avoiding.

> 
>>And does it mean that if I rmmod -a the unused cdrom module and later
>>try to mount /cdrom, the correct module won't be magically insmod'ed?
> 
> 
> If you don't have the /dev entry there, how would anything know to load
> the module?
> 

Does the devfs/udev /dev entry get removed when doing rmmod? I though 
not. But since the module isn't there anymore, doing mount /dev/cdrom 
/cdrom would give "No such device". Not a problem per se, but then 
probably rmmod -a isn't as a wise thing to do with udev as it is with 
devfs. Bad.
