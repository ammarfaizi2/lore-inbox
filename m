Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUD1INj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUD1INj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264690AbUD1INj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:13:39 -0400
Received: from math.ut.ee ([193.40.5.125]:23248 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264686AbUD1INi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:13:38 -0400
Date: Wed, 28 Apr 2004 11:13:35 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Anton Altaparmakov <aia21@cam.ac.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: New warnings on NTFS code
Message-ID: <Pine.GSO.4.44.0404281106040.24906-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.6-rc3 on sparc64. It has recently got some new warnings in
NTFS (there was a warning before but now there are more):

fs/ntfs/super.c: In function `parse_ntfs_boot_sector':
fs/ntfs/super.c:638: warning: long long unsigned int format, s64 arg (arg 4)
fs/ntfs/super.c: In function `ntfs_fill_super':
fs/ntfs/super.c:1523: warning: cast to pointer from integer of different size
fs/ntfs/super.c:1529: warning: cast to pointer from integer of different size
fs/ntfs/super.c:1634: warning: cast to pointer from integer of different size

The 3 new warnings are because of this definition:

#define OGIN    ((struct inode*)le32_to_cpu(0x4e49474f))        /* OGIN */

This seems suspicious - hardcoded pointer?

-- 
Meelis Roos (mroos@linux.ee)

