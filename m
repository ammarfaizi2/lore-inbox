Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUCSU42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUCSU42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:56:28 -0500
Received: from ns.suse.de ([195.135.220.2]:41147 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261186AbUCSUzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:55:25 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Chris Mason <mason@suse.com>
To: reiser@namesys.com
Cc: Peter Zaitsev <peter@mysql.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <405B5CB0.4090709@namesys.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
	 <1079643740.11057.16.camel@watt.suse.com>
	 <1079644190.2450.405.camel@abyss.local>
	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com>
	 <1079704347.11057.130.camel@watt.suse.com>
	 <1079724411.2576.178.camel@abyss.local>
	 <1079727833.11062.200.camel@watt.suse.com>  <405B58BB.1020208@namesys.com>
	 <1079728706.11061.210.camel@watt.suse.com>  <405B5CB0.4090709@namesys.com>
Content-Type: text/plain
Message-Id: <1079729783.11062.215.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Mar 2004 15:56:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 15:48, Hans Reiser wrote:
> Chris Mason wrote:
> 
> >
> >>
> >>and I was imprecise, I should have asked, does fsync flush the disk 
> >>cache regardless of what mount options are set or data/metadata touched 
> >>in the 2.6 patches?

> Forgive my relentlessness, is the answer to the above yes?

Yes ;-) One goal of the 2.6 patches is to make it possible for higher
levels to easily insert flushes when needed.  The reiserfs fsync and
ext3 fsync code will both do this.

I realized I wasn't clear about device mapper and md earlier, both need
extra work to aggregate the flushes down to the drives.  They don't yet
support flushing.

-chris


