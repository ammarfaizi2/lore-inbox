Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752585AbWKBGeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbWKBGeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 01:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbWKBGeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 01:34:09 -0500
Received: from smtp-out.google.com ([216.239.45.12]:55183 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752585AbWKBGeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 01:34:07 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=uxbT5L1YJPLtJJJJp96nf+Du6KoCU4k1gkKNi1QO/n7QHLOlIrhF4M0NFVIBik4Hq
	GTffHYGr62ReuFucQmMpw==
Message-ID: <454990F7.8040408@google.com>
Date: Wed, 01 Nov 2006 22:32:23 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Cornelia Huck <cornelia.huck@de.ibm.com>, Mike Galbraith <efault@gmx.de>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061031075825.GA8913@suse.de> <45477131.4070501@google.com> <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com> <4547833C.5040302@google.com> <20061031182919.3a15b25a@gondolin.boeblingen.de.ibm.com> <4547FABE.502@google.com> <20061101020850.GA13070@suse.de> <45480241.2090803@google.com> <20061102052409.GA9642@suse.de> <45498174.5070309@google.com> <20061102060225.GA11188@suse.de>
In-Reply-To: <20061102060225.GA11188@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Nov 01, 2006 at 09:26:12PM -0800, Martin J. Bligh wrote:
>>>>> Even with CONFIG_SYSFS_DEPRECATED enabled?  For some reason I'm guessing
>>>>> that you missed that suggestion a while back...
>>>> Yes - Enabling CONFIG_SYSFS_DEPRECATED didn't help.
>>> Ok, you are correct, for a stupid reason, this option didn't correctly
>>> work for a range of device types (I can get into the gory details if
>>> anyone really cares...)
>>>
>>> I've now fixed this up, and a few other bugs that I kept tripping on
>>> (which others also hit), and have refreshed my tree so that the next -mm
>>> will be much better in this area.
>>>
>>> If the problem persists (and I've built a zillion different kernels in
>>> different configurations today testing to make sure it doesn't), please
>>> let me know.
>>>
>>> I can post updated patches here if people want them.
>>>
>>> thanks for everyone's patience, I appreciated it.
>> Thanks for fixing this up. If you could post a diff somewhere against
>> either mainline or -mm, would make it easy to run through
>> test.kernel.org before you wake up tommorow ;-)
> 
> Oops, the newest -mm just came out without any of the driver core
> patches in it due to the problems.  I'll wait until the next -mm release
> then, and try to go catch up on my pending-patch-queue right now
> instead...

If we can test it out of sync, it'd save potentially messing up another
-mm cycle. The problem is that it blocks lots of other patches from
getting tested ...

M.
