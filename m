Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVDCHi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVDCHi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 03:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVDCHi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 03:38:56 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:34749 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261589AbVDCHir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 03:38:47 -0400
Message-ID: <424F9D59.5060907@yahoo.com.au>
Date: Sun, 03 Apr 2005 17:38:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Andreas Dilger <adilger@clusterfs.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Paul Jackson'" <pj@engr.sgi.com>, mingo@elte.hu, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
References: <200504020205.j32256g05369@unix-os.sc.intel.com> <Pine.LNX.4.62.0504022228080.5402@qynat.qvtvafvgr.pbz> <20050403065356.GV1753@schnapps.adilger.int> <Pine.LNX.4.62.0504022318160.5402@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0504022318160.5402@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> On Sat, 2 Apr 2005, Andreas Dilger wrote:
>
>>> given that this would let you get the same storage with about 1200 
>>> fewer
>>> drives (with corresponding savings in raid controllers, fiberchannel
>>> controllers and rack frames) it would be interesting to know how 
>>> close it
>>> would be (for a lot of people the savings, which probably are within
>>> spitting distance of $1M could be work the decrease in performance)
>>
>>
>> For benchmarks like these, the issue isn't the storage capacity, but
>> rather the ability to have lots of heads seeking concurrently to
>> access the many database tables.  At one large site I used to work at,
>> the database ran on hundreds of 1, 2, and 4GB disks long after they
>> could be replaced by many fewer, larger disks...
>
>
> I can understand this to a point, but it seems to me that after you 
> get beyond some point you stop gaining from this (simply becouse you 
> run out of bandwidth to keep all the heads busy). I would have guessed 
> that this happened somewhere in the hundreds of drives rather then the 
> thousands, so going from 1500x73G to 400x300G (even if this drops you 
> from 15Krpm to 10Krpm) would still saturate the interface bandwidth 
> before the drives
>

But in this case probably not - Ken increases IO capacity until the CPUs 
become saturated.
So there probably isn't a very large margin for error, you might need 
2000 of the slower
SATA disks to achieve a similar IOPS capacity.


