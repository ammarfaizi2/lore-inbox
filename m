Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSDBWKU>; Tue, 2 Apr 2002 17:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312972AbSDBWKL>; Tue, 2 Apr 2002 17:10:11 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29924 "EHLO
	e21.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S312962AbSDBWKA>; Tue, 2 Apr 2002 17:10:00 -0500
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.17
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF6D6C3786.6F0112B1-ON85256B8F.00799E30@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Tue, 2 Apr 2002 16:09:58 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/02/2002 05:09:58 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.17 of JFS was made available today.

Drop 55 on April 2, 2002 (jfs-2.4-1.0.17.tar.gz
and jfsutils-1.0.17.tar.gz) includes fixes to the file
system and utilities.

Utilities changes

- more rigorous dtree validation in fsck.jfs
- fix fsck.jfs to write to the fsck.jfs log properly on big endian machines
- fix xchklog to read the fsck.jfs log properly on big endian machines
- fix xpeek to display/modify PXD information properly on big endian
  machines
- replace fsck.jfs heartbeat with alarm() based heartbeat
  (Christoph Hellwig)
- improve mkfs.jfs and fsck.jfs parameter parsing and usage alerts
- messaging code cleanup, logredo code cleanup, general code cleanup (all)

File System changes

- Call sb_set_blocksize instead of set_blocksize in 2.5 (Christoph Hellwig)
- Replace strtok by strsep (Christoph Hellwig)
- Store entire device number in log superblock rather than just the minor.
- Include file clean (Christoph Hellwig)
- Fix race introduced by thread handling cleanups (Christoph Hellwig)
- Detect dtree corruption to avoid infinite loop
- JFS needs to include completion.h
- Support external log(journal) device file system work part 1
  (Christoph Hellwig)
- Store device number in JFS superblock and log superblock. This adds
  robustness to external journal replaying in case the device number
  changes between reboots.
- Superblock changes needed to support external journal. Removed some
  never-used fields and added a couple new ones.  The external
  journal support is not yet in mkfs.jfs and fsck.jfs, but is coming soon.

For more details about JFS, please see the patch instructions or
changelog.jfs files.


Steve
JFS for Linux http://oss.software.ibm.com/jfs







