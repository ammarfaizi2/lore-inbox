Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVDCH03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVDCH03 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 03:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDCH02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 03:26:28 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:16298 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261584AbVDCH0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 03:26:25 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Paul Jackson'" <pj@engr.sgi.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Date: Sat, 2 Apr 2005 23:23:23 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Industry db benchmark result on recent 2.6 kernels
In-Reply-To: <20050403065356.GV1753@schnapps.adilger.int>
Message-ID: <Pine.LNX.4.62.0504022318160.5402@qynat.qvtvafvgr.pbz>
References: <200504020205.j32256g05369@unix-os.sc.intel.com>
 <Pine.LNX.4.62.0504022228080.5402@qynat.qvtvafvgr.pbz>
 <20050403065356.GV1753@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2005, Andreas Dilger wrote:

>> given that this would let you get the same storage with about 1200 fewer
>> drives (with corresponding savings in raid controllers, fiberchannel
>> controllers and rack frames) it would be interesting to know how close it
>> would be (for a lot of people the savings, which probably are within
>> spitting distance of $1M could be work the decrease in performance)
>
> For benchmarks like these, the issue isn't the storage capacity, but
> rather the ability to have lots of heads seeking concurrently to
> access the many database tables.  At one large site I used to work at,
> the database ran on hundreds of 1, 2, and 4GB disks long after they
> could be replaced by many fewer, larger disks...

I can understand this to a point, but it seems to me that after you get 
beyond some point you stop gaining from this (simply becouse you run out 
of bandwidth to keep all the heads busy). I would have guessed that this 
happened somewhere in the hundreds of drives rather then the thousands, so 
going from 1500x73G to 400x300G (even if this drops you from 15Krpm to 
10Krpm) would still saturate the interface bandwidth before the drives

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
