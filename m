Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWFLI6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWFLI6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWFLI6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:58:12 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:61327 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750904AbWFLI6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:58:10 -0400
To: Theodore Tso <tytso@mit.edu>
Cc: Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>
	<20060609195750.GD10524@thunk.org>
From: Jes Sorensen <jes@sgi.com>
Date: 12 Jun 2006 04:58:09 -0400
In-Reply-To: <20060609195750.GD10524@thunk.org>
Message-ID: <yq0r71u3g4e.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ted" == Theodore Tso <tytso@mit.edu> writes:

Ted> On Fri, Jun 09, 2006 at 12:55:09PM -0400, Jeff Garzik wrote:
>> 1) clone a new tree 2) cp -a fs/ext3 fs/ext4 3) apply extent and
>> 48bit patches 4) apply related e2fsprogs patches
>> 
>> Then update ext4 step-by-step, using the normal Linux development
>> process.

Ted> We don't do this with the SCSI layer where we make a complete
Ted> clone of the driver layer so that there is a
Ted> /usr/src/linux/driver/scsi and /usr/src/linux/driver/scsi2, do
Ted> we?  And we didn't do that with the networking layer either, as
Ted> we added ipsec, ipv6, softnet, and a whole host of other changes
Ted> and improvements.

Maybe it's just me, but I am reading oranges vs apples there. The SCSI
comparison is like suggesting we go from the VFS to a VFS2 or fs/ ->
fs2/ for this. On the other hand going from ext3 -> ext4 to get
something incompatible (like enabling extends or 48 bit) is similar to
going net/ipv4 -> net/ipv6, which we did do indeed.

Fact of the matter is that 2.4 is dead or at least frozen solid by
now. The userland of most distros today wouldn't be able to boot with
a 2.4 kernel anyway.

Granted I am not a filesystem expert, but personally I would feel more
comfortable deciding to put my data on an ext4 file system knowing
that it was just that, rather than a hybrid.

Jes
