Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbTKFEKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 23:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTKFEKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 23:10:07 -0500
Received: from lvs00-fl-n02.valueweb.net ([216.219.253.98]:24805 "EHLO
	ams002.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S263334AbTKFEKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 23:10:04 -0500
Message-ID: <3FA9C974.3010002@coyotegulch.com>
Date: Wed, 05 Nov 2003 23:09:24 -0500
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
References: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com> <20031105230350.GB12992@work.bitmover.com>
In-Reply-To: <20031105230350.GB12992@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Wed, Nov 05, 2003 at 04:48:09PM -0600, Chad Kitching wrote:
> 
>>From: Zwane Mwaikambo
>>
>>>>+       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
>>>>+                       retval = -EINVAL;
>>>
>>>That looks odd
>>>
>>
>>Setting current->uid to zero when options __WCLONE and __WALL are set?  The 
>>retval is dead code because of the next line, but it looks like an attempt
>>to backdoor the kernel, does it not?
> 
> 
> It sure does.  Note "current->uid = 0", not "current->uid == 0". 
> Good eyes, I missed that.  This function is sys_wait4() so by passing in
> __WCLONE|__WALL you are root.  How nice.

In other words, the theoretical exploit was inserted by someone clever. 
Do we have any idea who?

BTW, good job catching the problem Larry.


-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

