Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWFISOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWFISOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWFISOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:14:21 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:12960 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751446AbWFISOU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:14:20 -0400
Date: Fri, 9 Jun 2006 12:14:26 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Matthew Frost <artusemrys@sbcglobal.net>
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609181426.GC5964@schatzie.adilger.int>
Mail-Followup-To: Matthew Frost <artusemrys@sbcglobal.net>,
	Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489B83E.9090104@sbcglobal.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  13:04 -0500, Matthew Frost wrote:
> Alex Tomas wrote:
> >sorry, I disagree. for example, NUMA isn't default and shouldn't be.
> >but we have it in the tree and any one may choose to use it.
> 
> NUMA is designed to cope with a hardware feature, which not everybody 
> has.  Filesystem upgrades are not qualitatively similar; it does not 
> depend on one's hardware design as to whether one uses ext3, let alone 
> extents.  Your logic is faulty.

If you have a > 8TB block device (which is common in large RAID devices
today, will be a single disk in a couple of years) then it is important
that your filesystem work with this block device.

If ext2 and ext3 didn't support > 2GB files (which was a filesystem
feature added in exactly the same way as extents are today, and nobody
bitched about it then) then they would be relegated to the same status
as minix and xiafs and all the other filesystems that are stuck in the
"we can't change" or "we aren't supported" camps.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

