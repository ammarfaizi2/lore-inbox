Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTLRVHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbTLRVHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:07:19 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:63124 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265326AbTLRVHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:07:17 -0500
Date: Thu, 18 Dec 2003 22:07:13 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: ext3 truncate bug in 2.6.0?
Message-ID: <20031218210713.GA21777@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When writing to the file, and the filesystem (ext3) is full, it
seems to block count gets wrong.

I ran an e2fsck on the fs and found no problems.  Then I mounted
it again, wrote a file until the fs was full, unmounted and ran
e2fsck again, and get this:

e2fsck 1.32 (09-Nov-2002)
Pass 1: Checking inodes, blocks, and sizes
Inode 276481, i_blocks is 681584, should be 681582.  Fix<y>?

If my memory is any good, their was a simular problem in 2.4
once.

I'm testing this with 2.6.0-test11, but couldn't find anything in
the changelog for 2.6.0.


Kurt

