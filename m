Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTAaVlG>; Fri, 31 Jan 2003 16:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTAaVlG>; Fri, 31 Jan 2003 16:41:06 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:5621 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S261854AbTAaVlG>; Fri, 31 Jan 2003 16:41:06 -0500
Date: Fri, 31 Jan 2003 14:50:18 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Larry McVoy <lm@bitmover.com>
Cc: bitkeeper-announce@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: bkbits.net downtime
Message-ID: <20030131145018.N3904@schatzie.adilger.int>
Mail-Followup-To: Larry McVoy <lm@bitmover.com>,
	bitkeeper-announce@bitmover.com, linux-kernel@vger.kernel.org
References: <200301312114.h0VLEmC11997@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301312114.h0VLEmC11997@work.bitmover.com>; from lm@bitmover.com on Fri, Jan 31, 2003 at 01:14:48PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 31, 2003  13:14 -0800, Larry McVoy wrote:
> Our T1 supplier, Global Crossing, is repairing a router at midnight 
> Saturday PST.  Expected downtime is 3 hours but you never know.  If 
> it turns out that they screw things up, we'll physically move bkbits.net
> to a different location Sunday or Monday.  

Actually, with BK it should be possible to have read only clones on
multiple servers, should it not?  Not that I'm saying BK should foot
the bill to do that, but having read-only clones of the primary kernel
trees would avoid most downtime.

I suppose it would be difficult for two servers to do a merge with
conflicts by themselves so multiple write clones are probably not super
desirable, but read-only clones should be pretty easy to set up and
keep up-to-date via "bk pull" (or even "bk push" triggered by a commit
script).

You could allow writing on a single read-only clone while the primary
is down and then update the primary when you move back, if that was an
issue, although I'm guessing that the DNS updates would take longer to
propagate than most outages.

I wonder if any of the kernel.org mirror sites would be interested in
hosting a clone of one or more BK repositories.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

