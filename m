Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbVKIRzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbVKIRzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVKIRzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:55:37 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:57609 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932655AbVKIRzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:55:36 -0500
Message-ID: <43723768.2060103@vmware.com>
Date: Wed, 09 Nov 2005 09:52:40 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, prasanna@in.ibm.com,
       ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de> <4370A9F5.4060103@vmware.com> <200511091438.11848.ak@suse.de> <437227FD.6040905@vmware.com> <20051109165804.GA15481@elte.hu>
In-Reply-To: <20051109165804.GA15481@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2005 17:52:41.0327 (UTC) FILETIME=[615B9FF0:01C5E556]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Zachary Amsden <zach@vmware.com> wrote:
>
>  
>
>>>I believe user space kprobes are being worked on by some IBM India folks 
>>>yes.
>>>      
>>>
>>I'm convinced this is pointless.  What does it buy you over a ptrace 
>>based debugger?  Why would you want extra code running in the kernel 
>>that can be done perfectly well in userspace?
>>    
>>
>
>kprobes are not just for 'debuggers', they are also used for tracing and 
>other dynamic instrumentation in projects like systemtap. Ptrace is way 
>too slow and limited for things like that.
>  
>

Well, if there is a justification for it, that means we really should 
handle all the nasty EIP conversion cases due to segmentation and v8086 
mode in the kprobes code.  I was hoping that might not be the case.

Zach
