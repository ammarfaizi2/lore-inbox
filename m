Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267151AbRGJVt4>; Tue, 10 Jul 2001 17:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbRGJVtg>; Tue, 10 Jul 2001 17:49:36 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:34965 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267151AbRGJVtb>; Tue, 10 Jul 2001 17:49:31 -0400
Date: Tue, 10 Jul 2001 16:49:18 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107102149.QAA36879@tomcat.admin.navo.hpc.mil>
To: cw@f00f.org, Brian Gerst <bgerst@didntduck.org>
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, ttabi@interactivesi.com,
        linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Jul 10, 2001 at 02:28:54PM -0400, Brian Gerst wrote:
> 
>     Jesse Pollard wrote:
> 
>         > If the entire page table were given to a user, then a full cache
>         > flush would have to be done on every context switch and system
>         > call. That would be very slow, but would allow a full 4G address
>         > for the user.
> 
>     A full cache flush would be needed at every entry into the kernel,
>     including hardware interrupts.  Very poor for performance.
> 
> Why would a cache flush be necessary at all? I assume ia32 caches
> where physically not virtually mapped?

Because the entire virtual mapping is replaced by that of the kernel.
This would invalidate the entire cache table. It was also pointed out
that this would have to be done for every interrupt too.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
