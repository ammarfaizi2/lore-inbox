Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267479AbTAXCBR>; Thu, 23 Jan 2003 21:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTAXCBQ>; Thu, 23 Jan 2003 21:01:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:30652 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267479AbTAXCBQ>;
	Thu, 23 Jan 2003 21:01:16 -0500
Date: Thu, 23 Jan 2003 18:10:42 -0800
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in
 2.5.53-mm1?
Message-Id: <20030123181042.025fcbbf.akpm@digeo.com>
In-Reply-To: <20030124012618.GA12005@rushmore>
References: <20030124012618.GA12005@rushmore>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 02:10:21.0317 (UTC) FILETIME=[BF89C350:01C2C34D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> Did you add a secret sauce to 2.5.59-mm2?

I have not been paying any attention to the I/O scheduler changes for a
couple of months, so I can't say exactly what caused this.  Possibly Nick's
batch expiry logic which causes the scheduler to alternate between reading
and writing with fairly coarse granularity.

>  10x sequential write improvement on ext3 for multiple tiobench threads.

OK...  

I _have_ been paying attention to the IO scheduler for the past few days. 
-mm5 will have the first draft of the anticipatory IO scheduler.  This of
course is yielding tremendous improvements in bandwidth when there are
competing reads and writes.

I expect it will take another week or two to get the I/O scheduler changes
really settled down.  Your assistance in thoroughly benching that would be
appreciated.

> 2.4.20aa1     8.24  7.21%    28.587   449134.11  0.10395  0.07086    114
> 2.5.59        9.50  5.50%    36.703     4310.62  0.00000  0.00000    173
> 2.5.59-mm2   35.28 17.69%    10.173    18950.56  0.01010  0.00000    199

boggle.


