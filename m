Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbUCPRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbUCPQsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:48:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264013AbUCPQeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:34:31 -0500
Message-ID: <40572C82.6020505@pobox.com>
Date: Tue, 16 Mar 2004 11:34:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       greg@kroah.com, bos@serpentine.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
References: <4056B0DB.9020008@pobox.com> <20040316005229.53e08c0c.akpm@osdl.org>
In-Reply-To: <20040316005229.53e08c0c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Too big to post,
>>
>> http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.5-rc1-klibc1.patch.bz2
>> 	or
>> bk://kernel.bkbits.net/jgarzik/klibc-2.5
>>
>> IIRC, this is:  my update of Bryan O'Sullivan's update of Greg KH's 
>> update of my merge of hpa's and viro's hacking :)
>>
>> WRT overall klibc merge:  when it can do md RAID autorun, it's 
>> mergeable.  And didn't somebody write a tiny mdctl program...
> 
> 
> It's so long since klibc was discussed (ie: more than five minutes ago)
> that I forget the reasons why it should be delivered via the kernel tree.
> 
> Remind me please?

Several reasons.  The big one in my mind is, it will be delivering 
pieces without which the kernel will not boot, so you really really want 
to keep that software in sync with the latest kernel...  at least until 
all the details are worked out.  Otherwise version skew will as we 
remove code from the kernel and move it to userspace will be painful -- 
users would be rebuilding their external klibc trees just about every 
day, as code was moved from kernel to early-userspace.

	Jeff




