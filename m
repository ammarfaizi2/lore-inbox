Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVDCGyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVDCGyM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDCGyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:54:12 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:29313 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261558AbVDCGyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:54:07 -0500
Date: Sat, 2 Apr 2005 23:53:56 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Paul Jackson'" <pj@engr.sgi.com>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-ID: <20050403065356.GV1753@schnapps.adilger.int>
Mail-Followup-To: David Lang <david.lang@digitalinsight.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Paul Jackson' <pj@engr.sgi.com>, mingo@elte.hu,
	nickpiggin@yahoo.com.au, torvalds@osdl.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200504020205.j32256g05369@unix-os.sc.intel.com> <Pine.LNX.4.62.0504022228080.5402@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504022228080.5402@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 02, 2005  22:36 -0800, David Lang wrote:
> On Fri, 1 Apr 2005, Chen, Kenneth W wrote:
> >To run this "industry db benchmark", assuming you have a 32-way numa box,
> >I recommend buying the following:
> >
> >512 GB memory
> >1500 73 GB 15k-rpm fiber channel disks
> >50 hardware raid controllers, make sure you get the top of the line model
> >  (the one has 1GB memory in the controller).
> >25 fiber channel controllers
> >4  gigabit ethernet controllers.
> >12 rack frames
> 
> Ken, given that you don't have the bandwidth to keep all of those disks 
> fully utilized, do you have any idea how big a performance hit you would 
> take going to larger, but slower SATA drives?
> 
> given that this would let you get the same storage with about 1200 fewer 
> drives (with corresponding savings in raid controllers, fiberchannel 
> controllers and rack frames) it would be interesting to know how close it 
> would be (for a lot of people the savings, which probably are within 
> spitting distance of $1M could be work the decrease in performance)

For benchmarks like these, the issue isn't the storage capacity, but
rather the ability to have lots of heads seeking concurrently to
access the many database tables.  At one large site I used to work at,
the database ran on hundreds of 1, 2, and 4GB disks long after they
could be replaced by many fewer, larger disks...

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

