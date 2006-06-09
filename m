Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWFIUJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWFIUJK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWFIUJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:09:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:1697 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030471AbWFIUJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:09:09 -0400
Message-ID: <4489D55F.20103@garzik.org>
Date: Fri, 09 Jun 2006 16:09:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org>
In-Reply-To: <20060609195750.GD10524@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> We don't do this with the SCSI layer where we make a complete clone of
> the driver layer so that there is a /usr/src/linux/driver/scsi and
> /usr/src/linux/driver/scsi2, do we?  And we didn't do that with the
> networking layer either, as we added ipsec, ipv6, softnet, and a whole
> host of other changes and improvements.  
> 
> What we do instead is we have a series of patches, which can be made
> available in various experimental trees, and as they get more
> polishing and experience with people using it without any problems,
> they can get merged into the -mm tree, and then eventually, when they
> are deemed ready, into mainline.  That is also the normal Linux
> development process, and it's worked quite well up until now with ext3.

No, there is a key difference between ext3 and SCSI/etc.:  cruft is removed.

In ext3, old formats are supported for all eternity.


> Folks seem to be worried about ext3 being "too important to experiment
> with", but the fact remains, we've been doing continuous improvement
> with ext3 for quite some time, and it's been quite smooth.  The htree
> introduction was essentially completely painless, for example --- and

I disagree.  There were some distro annoyances as I recall.


> people liked the fact that they could get the features of indexed
> directories without needing to do a complete dump and restore of the
> filesystem.

Of course people always like new features.  :)

ext4 should allow you to deliver new features more rapidly, while 
keeping the existing ext3 happily stable.

	Jeff


