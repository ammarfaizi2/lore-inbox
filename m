Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUI1UiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUI1UiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUI1UiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:38:07 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:22466 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267852AbUI1Uhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:37:42 -0400
Date: Tue, 28 Sep 2004 21:37:35 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6-BK-URL] NTFS: Final sparse annotation/fixes.
Message-ID: <Pine.LNX.4.60.0409282133290.4614@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

This are the final NTFS sparse annotation/fixes.  The first free patches 
are a re-send and the fourth and last patch changes all the defines back 
to simple enums since you made sparse happy with typed enums.

sparse with -Wbitwise now emits no warnings at all on NTFS (except for the 
four related to non-constant array declarations which are present without 
-Wbitwise as well).

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

 fs/ntfs/ChangeLog |    7 
 fs/ntfs/dir.c     |    3 
 fs/ntfs/inode.c   |    2 
 fs/ntfs/layout.h  |  731 ++++++++++++++++++++++++++++--------------------------
 fs/ntfs/logfile.h |   12 
 fs/ntfs/mft.c     |    8 
 fs/ntfs/super.c   |    4 
 fs/ntfs/unistr.c  |    2 
 8 files changed, 412 insertions(+), 357 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/09/26 1.1983.1.1)
   NTFS: Remove silly (__force le32) casts from __ntfs_is_magic{,p}
         helper functions.  Thanks to Al Viro for spotting them.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/26 1.1988.2.2)
   NTFS: Convert final enum (fs/ntfs/logfile.h) to define to silence last
         bitwise sparse warning.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/26 1.1988.2.3)
   NTFS: Change {const_,}cpu_to_le{16,32}(0) to just 0 as suggested by Al Viro.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/28 1.1994.1.2)
   NTFS: Change all the defines back to simple enums since sparse is now happy
         typed enums.  This completes the sparse annotations in NTFS.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
