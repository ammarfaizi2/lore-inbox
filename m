Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSKRSvY>; Mon, 18 Nov 2002 13:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSKRSvY>; Mon, 18 Nov 2002 13:51:24 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:26100 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262303AbSKRSvX>;
	Mon, 18 Nov 2002 13:51:23 -0500
Message-ID: <3DD937CB.2030304@us.ibm.com>
Date: Mon, 18 Nov 2002 10:56:11 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       riel@surriel.com, akpm@zip.com.au
Subject: Re: unusual scheduling performance
References: <Pine.LNX.4.44.0211181031400.979-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Mon, 18 Nov 2002, Andrew Morton wrote:
>> fs/eventpoll.c |    2 ++
>> 1 files changed, 2 insertions(+)
>>
>>--- 25/fs/eventpoll.c~hey	Mon Nov 18 10:13:40 2002
>>+++ 25-akpm/fs/eventpoll.c	Mon Nov 18 10:14:01 2002
>>@@ -328,6 +328,8 @@ void eventpoll_release(struct file *file
>> 	if (list_empty(lsthead))
>> 		return;
>>
>>+	printk("hey!\n");
>>+
> 
> Andrew, if you don't use epoll there's no way you get there. The function
> eventpoll_file_init() initialize the list at each file* init in
> fs/file_table.c
> If you're not using epoll and you get there, someone is screwing up the
> data inside the struct file

That little tidbit isn't even in .47.  Is that patch against one of 
the 2.5.47-mm's?

-- 
Dave Hansen
haveblue@us.ibm.com

