Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWFISR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWFISR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWFISR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:17:57 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:24718
	"EHLO sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S1750806AbWFISR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:17:56 -0400
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<m3y7w69s6v.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606091018150.5498@g5.osdl.org>
	<20060609174146.GO1651@parisc-linux.org>
From: Michael Poole <mdpoole@troilus.org>
Date: 09 Jun 2006 14:17:55 -0400
In-Reply-To: <20060609174146.GO1651@parisc-linux.org>
Message-ID: <87mzcmb3cc.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:

> On Fri, Jun 09, 2006 at 10:30:06AM -0700, Linus Torvalds wrote:
> > And I'm not saying that just because it's a filesystem, and people get 
> > upset if they lose data. No, I'm saying it because from a maintenance 
> > standpoint, such a filesystem has almost zero cost.
> 
> One of the costs (and I'm not disagreeing with your main point;
> I think forking ext3 to ext4 at this point is reasonable), is that
> bugfixes applied to one don't necessarily get applied to the other.
> I found some recently between ext2 and ext3, and submitted those, but I
> only audited one file.  There's lots more to look at and I just haven't
> found the time recently.  Going to three variations is a lot more work
> for auditing, and it might be worth splitting some bits which genuinely
> are the same into common code.

If you want more details on this kind of issue, look at CP-Miner.  A
paper published earlier this year in IEEE TSE[1] reports that that
tool found 421 cut-and-paste-related possible bugs in Linux, of which
49 were real bugs, 249 were false positives, and 123 could not be
proven either true or false positives.

[1]- http://doi.ieeecomputersociety.org/10.1109/TSE.2006.28

Michael Poole
