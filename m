Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWFIRls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWFIRls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWFIRls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:41:48 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:28366 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1030316AbWFIRlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:41:47 -0400
Date: Fri, 9 Jun 2006 11:41:46 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609174146.GO1651@parisc-linux.org>
References: <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <m3y7w69s6v.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091018150.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606091018150.5498@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 10:30:06AM -0700, Linus Torvalds wrote:
> And I'm not saying that just because it's a filesystem, and people get 
> upset if they lose data. No, I'm saying it because from a maintenance 
> standpoint, such a filesystem has almost zero cost.

One of the costs (and I'm not disagreeing with your main point;
I think forking ext3 to ext4 at this point is reasonable), is that
bugfixes applied to one don't necessarily get applied to the other.
I found some recently between ext2 and ext3, and submitted those, but I
only audited one file.  There's lots more to look at and I just haven't
found the time recently.  Going to three variations is a lot more work
for auditing, and it might be worth splitting some bits which genuinely
are the same into common code.

