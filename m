Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWBXQFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWBXQFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWBXQFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:05:03 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:9669 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750757AbWBXQFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:05:01 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 24 Feb 2006 16:04:38 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-git] NTFS: Release 2.1.26
Message-ID: <Pine.LNX.4.64.0602241559150.2136@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git

This is the next NTFS update containing some minor bugfixes and support 
for larger sector sizes (encountered on a 6TiB RAID array) and for invalid 
flags in the attribute list attribute of the $Secure system file 
(encountered on a Windows XP laptop).

Please apply.  Thanks!

Diffstat:

 Documentation/filesystems/ntfs.txt |    6 +
 fs/ntfs/ChangeLog                  |   36 ++++--
 fs/ntfs/Makefile                   |    2
 fs/ntfs/aops.c                     |   18 +--
 fs/ntfs/file.c                     |   11 --
 fs/ntfs/inode.c                    |   49 +++++++--
 fs/ntfs/layout.h                   |   26 +++-
 fs/ntfs/mft.c                      |    8 -
 fs/ntfs/ntfs.h                     |   10 -
 fs/ntfs/super.c                    |  201 ++++++++++++++++++++++++-------------
 fs/ntfs/upcase.c                   |   10 -
 fs/ntfs/volume.h                   |   29 ++---
 12 files changed, 263 insertions(+), 143 deletions(-)

I am sending the changesets as actual patches generated using git
format-patch for non-git users in follow up emails (in reply to this one).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
