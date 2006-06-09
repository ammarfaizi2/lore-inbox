Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWFIWhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWFIWhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWFIWhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:37:04 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:6823 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751415AbWFIWhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:37:01 -0400
Date: Fri, 9 Jun 2006 16:37:06 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Theodore Tso <tytso@mit.edu>, Matthew Frost <artusemrys@sbcglobal.net>,
       Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609223706.GJ5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Theodore Tso <tytso@mit.edu>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489D44A.1080700@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  16:04 -0400, Jeff Garzik wrote:
> Theodore Tso wrote:
> > And what ugly hacks are you talking about?  It's actually quite clean;
> > with the latest e2fsprogs, you use the same command (resize2fs) for
> > doing both online and offline resizing.
> 
> Consider a blkdev of size S1.  Using LVM we increase that value under 
> the hood to size S2, where S2 > S1.  We perform an online resize from 
> size S1 to S2.  The size and alignment of any new groups added will 
> different from the non-resize case, where mke2fs was run directly on a 
> blkdev of size S2.

Umm, and how is that a problem?  Either you want online resizing because
it provides some useful functionality, or you don't want it because you
are concerned with something that nobody else in the world is.  In the
latter case, don't use it.  Even if the metadata alignment is slightly
different on disk doesn't make it in any way an invalid filesystem.  In
fact, online resizing is 100% compatible after the resize back to the
dark ages of linux.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

