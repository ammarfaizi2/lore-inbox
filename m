Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263020AbREaQNR>; Thu, 31 May 2001 12:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263021AbREaQNF>; Thu, 31 May 2001 12:13:05 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:26898 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263020AbREaQMx>; Thu, 31 May 2001 12:12:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [UPDATE] Directory index for ext2
Date: Thu, 31 May 2001 18:13:43 +0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
MIME-Version: 1.0
Message-Id: <0105311813431J.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:

  - Freshen to 2.4.5
  - EXT2_FEATURE_COMPAT_DIR_INDEX flag finalized
  - Break up ext2_add_entry for aesthetic reasons (Al Viro)
  - Handle more than 64K directories per directory (Andreas Dilger)
  - Bug fix: new inode no longer inherits index flag (Andreas Dilger)
  - Bug fix: correct handling of error on index create (Al Viro)

To-Do:

  - More factoring of ext2_add_entry
  - Fall back to linear search in case of corrupted index
  - Finalize hash function

The patch is available at:

    http://nl.linux.org/~phillips/htree/dx.pcache-2.4.5   

It requires Al Viro's directory-in-pcache patch:

    ftp://ftp.math.psu.edu/pub/viro/ext2-dir-patch-S5.gz

To apply:

    cd mysource/linux
    zcat ext2-dir-patch-S5.gz | patch -p1
    cat dx.pcache-2.4.5 | patch -p0

To create an indexed directory:

    mount /dev/hdxxx /test -o index
    mkdir /test/foo

No known bugs, please test, thanks in advance.

--
Daniel

