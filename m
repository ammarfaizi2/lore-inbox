Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315235AbSEQAfF>; Thu, 16 May 2002 20:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315236AbSEQAfE>; Thu, 16 May 2002 20:35:04 -0400
Received: from dsl-213-023-040-248.arcor-ip.net ([213.23.40.248]:56808 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315235AbSEQAe7>;
	Thu, 16 May 2002 20:34:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Htree directory index for Ext2, updated
Date: Fri, 17 May 2002 02:34:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Li, Chris" <cli@archway.com>, Ted Tso <tytso@thunk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178Vhr-0008Vj-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated version of the htree directory index patch for Ext2 is available
at:

   nl.linux.org/~phillips/htree/htree-2.4.18-2

This update fixes a corruption-causing bug.

After learning to my horror that gnu patch will, if a patch was made to be 
applied with option -p0, sometimes apply patches to your 'clean' tree (the 
one with the ---'s) instead of the target tree (the one with the +++'s) I 
decided to switch to -p1, and that is how this patch is to be applied.

Changes:

  - Off-by-one bug in second level index block splitting identified
    by Ted using his prototype Htree extensions to e2fsck, isolated using
    same, and fixed by Chris Li (Ted, Chris)

  - Added a missing static, allowing htree to be applied to
    Ext2 and Ext3 simultaneously, withload symbol conflicts (Me)

News:

  - Htree has been ported to Ext3 by Chris Li, patch to be available soon.
    (Chris, do you need a place to post it?)

In progress:

  - Port to Ext3 (Chris)
  - e2fsprogs extensions (Ted)
  - Tuning/testing/finalizing of hash function
  - Delete coalescing

To do:

  - Highmem support (currently buggy)
  - telldir cookie(s)
  - Hash attack resistance
  - Source cleanup
  - Port to 2.5

-- 
Daniel
