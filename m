Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUCCGa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 01:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUCCGa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 01:30:58 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21935 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261338AbUCCGa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 01:30:56 -0500
Message-ID: <40457B9E.3060706@namesys.com>
Date: Wed, 03 Mar 2004 09:30:54 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: Peter Nelson <pnelson@andrew.cmu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@oss.software.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
References: <4044119D.6050502@andrew.cmu.edu> <4044366B.3000405@namesys.com>	 <4044B787.7080301@andrew.cmu.edu> <1078266793.8582.24.camel@mentor.gurulabs.com>
In-Reply-To: <1078266793.8582.24.camel@mentor.gurulabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately it is a bit more complex, and the truth is less 
complementary to us than what you write.  Reiser4's CPU usage has come 
down a lot, but it still consumes more CPU than V3.  It should consume 
less, and Zam is currently working on making writes more CPU efficient.  
As soon as I get funding from somewhere and can stop worrying about 
money, I will do a complete code review, and CPU usage will go way 
down.  There are always lots of stupid little things that consume a lot 
of CPU that I find whenever I stop chasing money and review code.

We are shipping because CPU usage is not as important as IO efficiency 
for a filesystem, and while Reiser4 is not as fast as it will be in 3-6 
months, it is faster than anything else available so it should be shipped.

Hans

Dax Kelson wrote:

>On Tue, 2004-03-02 at 09:34, Peter Nelson wrote:
>  
>
>>Hans Reiser wrote:
>>
>>I'm confused as to why performing a benchmark out of cache as opposed to 
>>on disk would hurt performance?
>>    
>>
>
>My understanding (which could be completely wrong) is that reieserfs v3
>and v4 are algorithmically more complex than ext2 or ext3. Reiserfs
>spends more CPU time to make the eventual ondisk operations more
>efficient/faster.
>
>When operating purely or mostly out of ram, the higher CPU utilization
>of reiserfs hurts performance compared to ext2 and ext3.
>
>When your system I/O utilization exceeds cache size and your disks
>starting getting busy, the CPU time previously invested by reiserfs pays
>big dividends and provides large performance gains versus more
>simplistic filesystems.  
>
>In other words, the CPU penalty paid by reiserfs v3/v4 is more than made
>up for by the resultant more efficient disk operations. Reiserfs trades 
>CPU for disk performance.
>
>In a nutshell, if you have more memory than you know what do to with,
>stick with ext3. If you spend all your time waiting for disk operations
>to complete, go with reiserfs.
>
>Dax Kelson
>Guru Labs
>
>
>
>  
>


-- 
Hans


