Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWFIT6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWFIT6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWFIT6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:58:04 -0400
Received: from thunk.org ([69.25.196.29]:5544 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030462AbWFIT6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:58:02 -0400
Date: Fri, 9 Jun 2006 15:57:50 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609195750.GD10524@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489A7ED.8070007@garzik.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 12:55:09PM -0400, Jeff Garzik wrote:
> That is what the entirety of Linux development is -- step-by-step.
> 
> It is OBVIOUS that it would take five minutes to start ext4.
> 
> 1) clone a new tree
> 2) cp -a fs/ext3 fs/ext4
> 3) apply extent and 48bit patches
> 4) apply related e2fsprogs patches
> 
> Then update ext4 step-by-step, using the normal Linux development process.

We don't do this with the SCSI layer where we make a complete clone of
the driver layer so that there is a /usr/src/linux/driver/scsi and
/usr/src/linux/driver/scsi2, do we?  And we didn't do that with the
networking layer either, as we added ipsec, ipv6, softnet, and a whole
host of other changes and improvements.  

What we do instead is we have a series of patches, which can be made
available in various experimental trees, and as they get more
polishing and experience with people using it without any problems,
they can get merged into the -mm tree, and then eventually, when they
are deemed ready, into mainline.  That is also the normal Linux
development process, and it's worked quite well up until now with ext3.

Folks seem to be worried about ext3 being "too important to experiment
with", but the fact remains, we've been doing continuous improvement
with ext3 for quite some time, and it's been quite smooth.  The htree
introduction was essentially completely painless, for example --- and
people liked the fact that they could get the features of indexed
directories without needing to do a complete dump and restore of the
filesystem.

						- Ted
