Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUDUNnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUDUNnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 09:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUDUNnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 09:43:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42392 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262389AbUDUNnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 09:43:04 -0400
Message-ID: <40867A2A.9070709@us.ibm.com>
Date: Wed, 21 Apr 2004 08:42:02 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [PATCH] Use workqueue for call_usermodehelper
References: <1082345766.30154.13.camel@bach> <20040419113854.H22989@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Rusty Russell (rusty@rustcorp.com.au) wrote:
> 
>>[ Vatsa, this should solve your NUMA+HOTPLUG_CPU deadlock too, I think ]
>>
>>This uses the create_singlethread_workqueue() function presented in the
>>last patch, although it could just as easily use create_workqueue().
> 
> 
> Nice, this seems like it should fixup the problem Brian was seeing too,
> and maintain return code from kernel_thread(), etc. instead of the async
> option.  Brian, did you give these changes a whirl? (they're in latest
> -mm tree)

I tried out the fix on my system and it seemed to work fine. However, I
am having trouble recreating the deadlock with old code now that my
system has been reconfigured...

-Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

