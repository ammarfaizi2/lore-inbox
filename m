Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUDIVF6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUDIVF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 17:05:58 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18610 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261748AbUDIVF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 17:05:57 -0400
Message-ID: <4077101A.7050303@us.ibm.com>
Date: Fri, 09 Apr 2004 16:05:30 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org> <20040407061146.GA10413@kroah.com> <407487A6.8020904@us.ibm.com> <20040408224713.GD15125@kroah.com> <40770AD0.4000402@us.ibm.com> <20040409205344.GA5236@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Apr 09, 2004 at 03:42:56PM -0500, Brian King wrote:
> 
>>Would you prefer a fix in call_usermodehelper itself? It could certainly
>>be argued that calling call_usermodehelper with wait=0 should be allowed
>>even when holding locks. Although, fixing it here is less obvious to me
>>how to do because of the arguments to call_usermodehelper. I would imagine
>>it would consist of creating a kernel_thread to preserve the caller's stack.
> 
> 
> Yes, I think call_usermodehelper should be changed to create a new
> kernel thread for every call.  That would solve this problem, and any
> future races that might happen.  Care to work on that?

I'll give it a shot.

-Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

