Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVAYKuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVAYKuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVAYKuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:50:50 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:53422 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261884AbVAYKud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:50:33 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-BK-URL] NTFS: Fix a potential DoS by rate limiting printk().
Message-Id: <E1CtOGy-0003qr-2z@imp.csi.cam.ac.uk>
Date: Tue, 25 Jan 2005 10:50:12 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Hi Andrew, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

This fixes a potential DoS attack in NTFS by rate limiting printk() when the
driver is not compiled with debugging enabled.  Thanks to Carl-Daniel
Heilfinger from SuSE for pointing this out.

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

 fs/ntfs/ChangeLog |    7 +++++++
 fs/ntfs/debug.c   |    8 ++++++++
 2 files changed, 15 insertions(+)

through these ChangeSets:

<aia21@cantab.net> (05/01/25 1.1983.6.1)
   NTFS: Add printk rate limiting for ntfs_warning() and ntfs_error() when
         compiled without debug.  This avoids a possible denial of service
         attack.  Thanks to Carl-Daniel Hailfinger from SuSE for pointing this
         out.

