Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVATDYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVATDYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVATDYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:24:09 -0500
Received: from news.suse.de ([195.135.220.2]:25811 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262027AbVATDXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:23:23 -0500
Message-Id: <20050120020124.110155000@suse.de>
Date: Thu, 20 Jan 2005 03:01:24 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Tridgell <tridge@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: [ea-in-inode 0/5] Further fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here is a set of fixes for ext3 in-inode attributes:

patches/ea-xattr-nolock.diff
  No lock needed when freeing inode

  The effect of the additional lock taking is very minor, but
  it's still unnecessary.

patches/ea-xattr-update-sb.diff
  Set the EXT3_FEATURE_COMPAT_EXT_ATTR for in-inode xattrs

  The EXT_ATTR filesystem feature was set for xattr blocks, but not
  for in-inode attributes.

patches/ea-xattr-doc.diff
  Documentation fix

patches/ea-xattr-no-extra_isize.diff
  Fix i_extra_isize check

  Filesystem corruption fix.

patches/ea-xattr-reserved-inodes.diff
  Disallow in-inode attributes for reserved inodes

  Filesystem corruption fix.


Regards,
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

