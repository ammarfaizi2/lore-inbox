Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTDLOXx (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 10:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTDLOXx (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 10:23:53 -0400
Received: from [203.197.168.150] ([203.197.168.150]:24338 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263275AbTDLOXw (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 10:23:52 -0400
Message-ID: <3E982404.70106@tataelxsi.co.in>
Date: Sat, 12 Apr 2003 20:04:44 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Organization: Tata Elxsi
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems in kernel memory allocation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having problems allocating more than 2.5 MB in the linux kernel.
I am using Linux 2.4.7-10 RH 7.2 on i386.

Physical RAM: 64 MB

I tried two methods of allocation, one using kmalloc and other using 
kmem_cache_alloc. Both of them failed to allocate more than 2.5 MB. 
(GFP_KERNEL / GFP_ATOMIC operations)
When I run 'free' I am able to see that the free physical memory is 
about 4MB and the free buffers/cache is about 52 MB.
The report is as follows:
           total       used       free     shared    buffers     cached
Mem:         62264      57928      4336          0       30152      17768
-/+ buffers/cache:       10008      52256
Swap:       192772          0     192772

I also found out that the /proc/meminfo had about 43MB of Inact_dirty . 
Is there any way to forcefully flush the dirty buffers ?
Why is the allocation consistently failing in about 2.5 or 3MB ?
Only when the free physical is about 30MB and I start allocating am I 
able to successfully allocate about 5MB.

Is there a restriction as to how much memory you can allocate in the 
kernel ?

Sriram



