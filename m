Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVKHMxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVKHMxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVKHMxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:53:46 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:61453 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965061AbVKHMxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:53:45 -0500
Message-ID: <43709FD7.1030905@vmware.com>
Date: Tue, 08 Nov 2005 04:53:43 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 14/21] i386 Apm is on cpu zero only
References: <200511080433.jA84Xwm7009921@zach-dev.vmware.com> <20051108073315.GE28201@elte.hu>
In-Reply-To: <20051108073315.GE28201@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2005 12:53:44.0727 (UTC) FILETIME=[73E5EA70:01C5E463]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Zachary Amsden <zach@vmware.com> wrote:
>
>  
>
>>APM BIOS code has a protective wrapper that runs it only on CPU zero.  
>>Thus, no need to set APM BIOS segments in the GDT for other CPUs.
>>    
>>
>
>hm, do we want (need) to have that CPU#0 assumption forever?
>  
>

Can't hurt, and APM is largely obsolete because of ACPI, so I'm only 
concerned with trimming and keeping adequate protection of the kernel 
from APM code while maintaining correctness.  I don't have a nice set of 
old machines with enough wacky APM BIOSen to validate that unpinning the 
CPU is ok.

Zach
