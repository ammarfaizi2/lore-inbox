Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbUCCClD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 21:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbUCCClD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 21:41:03 -0500
Received: from ns.suse.de ([195.135.220.2]:2439 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262330AbUCCClA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 21:41:00 -0500
To: David Weinehall <david@southpole.se>
Cc: Dax Kelson <dax@gurulabs.com>, Peter Nelson <pnelson@andrew.cmu.edu>,
       Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
References: <4044119D.6050502@andrew.cmu.edu>
	<4044366B.3000405@namesys.com>
	<4044B787.7080301@andrew.cmu.edu>
	<1078266793.8582.24.camel@mentor.gurulabs.com>
	<20040302224758.GK19111@khan.acc.umu.se>
	<40453538.8050103@animezone.org>
	<20040303014115.GP19111@khan.acc.umu.se>
From: Andi Kleen <ak@suse.de>
Date: 03 Mar 2004 03:39:26 +0100
In-Reply-To: <20040303014115.GP19111@khan.acc.umu.se.suse.lists.linux.kernel>
Message-ID: <p73ptbu4psx.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <david@southpole.se> writes:

> On Tue, Mar 02, 2004 at 08:30:32PM -0500, Andrew Ho wrote:
> > XFS is the best filesystem.
> 
> Well it'd better be, it's 10 times the size of ext3, 5 times the size of
> ReiserFS and 3.5 times the size of JFS.

I think your ext3 numbers are off, most likely you didn't include JBD. 

> And people say size doesn't matter.

A lot of this is actually optional features the other FS don't have,
like support for separate realtime volumes and compat code for old 
revisions, journaled quotas etc. I think you could
relatively easily do a "mini xfs" that would be a lot smaller. 

But on today's machines it's not really an issue anymore.

-Andi
