Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUDPR4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 13:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDPR4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 13:56:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24776 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263442AbUDPR4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 13:56:30 -0400
Message-ID: <40801E0D.70902@us.ibm.com>
Date: Fri, 16 Apr 2004 12:55:25 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
References: <4072F2B7.2070605@us.ibm.com>	<20040406172903.186dd5f1.akpm@osdl.org>	<20040407061146.GA10413@kroah.com>	<407487A6.8020904@us.ibm.com>	<20040408224713.GD15125@kroah.com>	<40770AD0.4000402@us.ibm.com>	<20040409205344.GA5236@kroah.com>	<20040409141511.4e372554.akpm@osdl.org>	<20040410165322.GG1317@kroah.com>	<20040410131137.0eff0ae2.akpm@osdl.org>	<407AB4FD.4070905@us.ibm.com> <20040412104638.7b1d0124.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied and tested the new patches in the mm tree and it works fine
for me.

Thanks

-Brian


Andrew Morton wrote:
> Brian King <brking@us.ibm.com> wrote:
> 
>>>>Ok, you've convinced me of the mess that would cause.  So what should we
>>>
>> >> do to help fix this?  Serialize call_usermodehelper()?
>> > 
>> > 
>> > May as well bring back call_usermodehelper_async() I guess.
>> > 
>> > 
>> > There are two patches here, and they are totally untested...
>>
>> I loaded the patches on my ppc64 box and they worked fine after I fixed a compile
>> bug. The attached patch fixes the compile bug and changes the call_usermodehelper
>> call in kset_hotplug to call_usermodehelper_async.
> 
> 
> yup, thanks.  I've changed the patch in my tree so that we always perform
> the fully-async operation if call_usermodehelper() is passed "wait=0".  It
> gets the new code some more testing and keeps the kernel API simpler.
> 
> 


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

