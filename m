Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136357AbRD2UtN>; Sun, 29 Apr 2001 16:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136360AbRD2UtE>; Sun, 29 Apr 2001 16:49:04 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:49936 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S136357AbRD2Usu>; Sun, 29 Apr 2001 16:48:50 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: viro@math.psu.edu
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010429203512Z92376-12380+28@humbolt.nl.linux.org>
Date: Sun, 29 Apr 2001 22:35:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4.gz

Here is my ext2 directory index as a patch against your patch:

    http://kernelnewbies.org/~phillips/htree/dx.pcache-2.4.4
    
Changes:

    - COMBSORT macro replaced by custom sort code
    - Most #ifdef CONFIG_EXT2_INDEX's changed to if (<constant>)

To do:

  - Split up the split code
  - Finalize hash function
  - Test/debug big endian
  - Fall back to linear search if bad index detected
  - Fail gracefully on random data
  - Remove the tracing and test options

To apply:

    cd source/tree
    zcat ext2-dir-patch-S4.gz | patch -p1
    cat dx.pcache-2.4.4 | patch -p0

To create an indexed directory:

    mount /dev/hdxxx /test -o index
    mkdir /test/foo
