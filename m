Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVA0RnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVA0RnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVA0Rkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:40:42 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:47756 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262674AbVA0RjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:39:08 -0500
Message-ID: <41F927E4.7070607@tmr.com>
Date: Thu, 27 Jan 2005 12:41:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: Matt Domsch <Matt_Domsch@Dell.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.11-rc2] modules: add version and srcversion to sysfs
References: <20050126140935.GA27641@lists.us.dell.com><20050119171357.GA16136@lst.de> <1106757530.13004.220.camel@winden.suse.de>
In-Reply-To: <1106757530.13004.220.camel@winden.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> On Wed, 2005-01-26 at 15:09, Matt Domsch wrote:
> 
>>On Wed, Jan 26, 2005 at 10:22:29AM +0100, Andreas Gruenbacher wrote:
>>
>>>On Wednesday 26 January 2005 07:05, Matt Domsch wrote:
>>>
>>>>Module:  Add module version and srcversion to the sysfs tree
>>>
>>>why do you need this?
>>
>>a) Tools like DKMS, which deal with changing out individual kernel
>>modules without replacing the whole kernel, can behave smarter if they
>>can tell the version of a given module.
> 
> 
> They can look at the modules in /lib/modules/$(uname -r).

I think he means he wants to know what's in memory, not on the disk.

[ snip ]
> 
>>c) as the unbind-driver-from-device work takes shape, it will be
>>possible to rebind a driver that's built-in (no .ko to modinfo for the
>>version) to a newly loaded module.  sysfs will have the
>>currently-built-in version info, for comparison.
>>
>>d) tech support scripts can then easily grab the version info for
>>what's running presently - a question I get often.
> 
> 
> That's something you can do entirely in userspace by looking at the *.ko
> files.

How do you find which *.ko file was used to load the module in memory? I 
think you are talking about two things here.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
