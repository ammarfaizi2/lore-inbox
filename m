Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVCCMA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVCCMA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCCLLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:11:18 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:22503 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261560AbVCCK7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:59:01 -0500
Date: Thu, 3 Mar 2005 10:58:44 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Miklos Szeredi <miklos@szeredi.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
In-Reply-To: <20050302123123.3d528d05.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0503031053340.26782@hermes-1.csi.cam.ac.uk>
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu> <20050302123123.3d528d05.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Andrew Morton wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Do you have any objections to merging FUSE in mainline kernel?
> 
> I was planning on sending FUSE into Linus in a week or two.

I would certainly vote for FUSE going in.  Even if it has some bits that 
could be improved the code works well.  It has been in global use for 
quite a while.  We use it in a production environment on four servers and 
over 650 workstations to provide a "magic symlink filesystem" (i.e. 
symlink XYZ points to different place depending on which user looks at it) 
and we have not experienced any problems.  I have also done other testing 
with a layering fs using fuse and that was very stable (but slower than 
the symlink approach which is why we went for that).

FUSE may not be perfect but lets face it - which code is?  And more 
importantly a lot of code in the kernel is broken (for at least some 
people) yet it is in the kernel and FUSE does work well...

Just my 2p.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
