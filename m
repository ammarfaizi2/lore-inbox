Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVBOUsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVBOUsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVBOUsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:48:23 -0500
Received: from server262.com ([64.14.68.15]:40166 "HELO server262.com")
	by vger.kernel.org with SMTP id S261876AbVBOUrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:47:23 -0500
Subject: Re: Optimizing disk-I/O [was Re: [ANNOUNCE] hotplug-ng 001 release]
From: Adam Goode <adam@evdebs.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Diego Calleja <diegocg@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       prakashp@arcor.de, paolo.ciarrocchi@gmail.com, gregkh@suse.de,
       pmcfarland@downeast.net, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050215195614.GT23424@austin.ibm.com>
References: <20050215004329.5b96b5a1.diegocg@gmail.com>
	 <20050215195614.GT23424@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 15:46:56 -0500
Message-Id: <1108500416.17531.35.camel@lynx.auton.cs.cmu.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac OS X has a similar thing, with a pretty simple description of how
they do it:

http://developer.apple.com/technotes/tn/tn1150.html#HotFile



Adam



On Tue, 2005-02-15 at 13:56 -0600, Linas Vepstas wrote:
> On Tue, Feb 15, 2005 at 12:43:29AM +0100, Diego Calleja was heard to remark:
> > 
> > Also, it analyzes all those io "logs" and defragments 
> 
> I dislike hearing/reading about what XP does, since its probably patented,
> and I don't want that shadow hanging over Linux.
> 
> I assume that the following simple idea, obvious to any practictioner 
> versed in the state of the art, is not patented or patentable:
> 
> > linux can do decisions like "this system starts openoffice, so I'm going to move the
> > binaries to another place of the disk where they'll load faster" or "when X program
> > uses /lib/libfoo.so it also uses /lib/libbar.so, so I'm going to put those two together
> > in the disk because that will avoid seeks". 
> 
> Now I like this idea. It need not have anything to do with startup,
> or with any particular program or distro whatsoever.  Rather, one 
> would have a daemon keeping track of disk i/o patterns, and constantly 
> trying to figure out if there is a rearrangement of the sectors on disk
> that would minimize i/o seeks based on past uasge. 
> 
> The optimization routine could be some simulated annealing or 
> genetic algorithm or whatever whiz-bang technique someone is into.
> Just keep it running in the background, low priority, constantly...
> This would give you the best "time weighted" disk access performance,
> although it would potentially hurt boot times, since most users spend
> most of thier time doing disk access other than booting ... 
> 
> --linas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

