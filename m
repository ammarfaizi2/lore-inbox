Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWAJS6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWAJS6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWAJS6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:58:30 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:37271 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751189AbWAJS63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:58:29 -0500
Message-ID: <43C3EB4A.6000606@wolfmountaingroup.com>
Date: Tue, 10 Jan 2006 10:13:46 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2G memory split
References: <E1EwNc8-00063F-00@calista.inka.de> <43C3E142.1080206@wolfmountaingroup.com> <20060110185030.GB26581@csclub.uwaterloo.ca>
In-Reply-To: <20060110185030.GB26581@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

>On Tue, Jan 10, 2006 at 09:30:58AM -0700, Jeff V. Merkey wrote:
>  
>
>>Bernd Eckenfels wrote:
>>
>>Here are the patches I use for the splitting.  They work well.    The 
>>methods employed in Red Hat ES are far better and I am surprised
>>no one has simply integrated those patches into the kernel which are 4GB 
>>/ 4GB  kernel/user. 
>>    
>>
>
>I was under the impression the 4G/4G split had some non negligable
>performance penalties compared to the other options.
>  
>

It does, but from my testing, I/O performance and app performance seems 
negligible. I run the highest performing app/driver
on Linux for disk and network I/O loading and ES3 and ES4 are just as 
performant with 4:4 as FC2, FC3, and FC4 with
3:1.

I am now able to capture 4 x gigabit segments with 3:1 at sustained 
stream to disk rates of 497 MB/S
and 1 x 10Gbe at 517 MB/S stream to disk. I see no appreciable 
performance differences 3:1 vs. 4:4. Modern Xeon
processors have gotten a lot better dealing with TLB invalidation. I 
suppose applications that remap
memory all over the place or that do tons of swapping would see some 
penalty, and I do see some
performance degredation when user space apps start swapping, but it's 
difficult to quantify how much is related
to disk I/O latency vs. TLB overhear. Most TLB flushes will cost you 150 
clocks over time as the TLB reloads
itself.

Jeff

>Len Sorensen
>
>  
>

