Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269130AbUIZAWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269130AbUIZAWa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269447AbUIZAWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:22:30 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:62081 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269131AbUIZAWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:22:16 -0400
Date: Sun, 26 Sep 2004 01:22:10 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-BK-URL] NTFS: Final sparse related cleanups.
Message-ID: <Pine.LNX.4.60.0409260119140.30504@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

These are just a few more cleanups, mostly that Al suggested.

Please apply.  Thanks!

For the benefit of non-BK users and to make code review easier, I am
sending each ChangeSet in a separate email as a diff -u style patch.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 fs/ntfs/ChangeLog |    1 +
 fs/ntfs/dir.c     |    3 +--
 fs/ntfs/inode.c   |    2 +-
 fs/ntfs/layout.h  |    4 ++--
 fs/ntfs/logfile.h |    7 +++----
 fs/ntfs/mft.c     |    8 ++++----
 fs/ntfs/super.c   |    4 ++--
 fs/ntfs/unistr.c  |    2 +-
 8 files changed, 15 insertions(+), 16 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/09/26 1.1983.1.1)
   NTFS: Remove silly (__force le32) casts from __ntfs_is_magic{,p}
         helper functions.  Thanks to Al Viro for spotting them.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/26 1.1990)
   NTFS: Convert final enum (fs/ntfs/logfile.h) to define to silence last
         bitwise sparse warning.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/26 1.1991)
   NTFS: Change {const_,}cpu_to_le{16,32}(0) to just 0 as suggested by Al Viro.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

