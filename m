Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVBOUAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVBOUAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVBOT7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:59:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:42721 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261848AbVBOT4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:56:23 -0500
Date: Tue, 15 Feb 2005 13:56:14 -0600
To: Diego Calleja <diegocg@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, prakashp@arcor.de,
       paolo.ciarrocchi@gmail.com, gregkh@suse.de, pmcfarland@downeast.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Optimizing disk-I/O [was Re: [ANNOUNCE] hotplug-ng 001 release]
Message-ID: <20050215195614.GT23424@austin.ibm.com>
References: <20050215004329.5b96b5a1.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215004329.5b96b5a1.diegocg@gmail.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 12:43:29AM +0100, Diego Calleja was heard to remark:
> 
> Also, it analyzes all those io "logs" and defragments 

I dislike hearing/reading about what XP does, since its probably patented,
and I don't want that shadow hanging over Linux.

I assume that the following simple idea, obvious to any practictioner 
versed in the state of the art, is not patented or patentable:

> linux can do decisions like "this system starts openoffice, so I'm going to move the
> binaries to another place of the disk where they'll load faster" or "when X program
> uses /lib/libfoo.so it also uses /lib/libbar.so, so I'm going to put those two together
> in the disk because that will avoid seeks". 

Now I like this idea. It need not have anything to do with startup,
or with any particular program or distro whatsoever.  Rather, one 
would have a daemon keeping track of disk i/o patterns, and constantly 
trying to figure out if there is a rearrangement of the sectors on disk
that would minimize i/o seeks based on past uasge. 

The optimization routine could be some simulated annealing or 
genetic algorithm or whatever whiz-bang technique someone is into.
Just keep it running in the background, low priority, constantly...
This would give you the best "time weighted" disk access performance,
although it would potentially hurt boot times, since most users spend
most of thier time doing disk access other than booting ... 

--linas

