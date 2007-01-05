Return-Path: <linux-kernel-owner+w=401wt.eu-S1750791AbXAEWEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXAEWEU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 17:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbXAEWEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 17:04:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:12380 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbXAEWEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 17:04:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,155,1167638400"; 
   d="scan'208"; a="33390071:sNHT21375963"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <jens.axboe@oracle.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Nick Piggin" <npiggin@suse.de>
Subject: RE: [PATCH] 4/4 block: explicit plugging
Date: Fri, 5 Jan 2007 14:04:19 -0800
Message-ID: <000101c73115$72cf2200$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccwDa6YKgjJw/n7QJSpqWy53dQYpQBBgoNw
In-Reply-To: <20070104143900.GC11203@kernel.dk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, January 03, 2007 12:09 AM
> Do you have any benchmarks which got faster with these changes?

Jens Axboe wrote on Wednesday, January 03, 2007 12:22 AM
> I've asked Ken to run this series on some of his big iron, I hope he'll
> have some results for us soonish. I can run some pseudo benchmarks on a
> 4-way here with some simulated storage to demonstrate the locking
> improvements.

> Jens Axboe wrote on Thursday, January 04, 2007 6:39 AM
> > I will just retake the tip of your plug tree and retest.
> 
> That would be great! There's a busy race fixed in the current branch,
> make sure that one is included as well.


Good news: the tip of plug tree fixed the FC loop reset issue we are
seeing earlier.

Performance wise, our big db benchmark run came out with 0.14% regression
compare to 2.6.20-rc2.  It is small enough that we declared it as noise
level change. Unfortunately our internal profile tool broke on 2.6.20-rc2
so I don't have an execution profile to post.

- Ken
