Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313529AbSDUQ3U>; Sun, 21 Apr 2002 12:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313556AbSDUQ3T>; Sun, 21 Apr 2002 12:29:19 -0400
Received: from flaxian.hitnet.RWTH-Aachen.DE ([137.226.181.79]:19984 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S313529AbSDUQ3Q>;
	Sun, 21 Apr 2002 12:29:16 -0400
Date: Sun, 21 Apr 2002 18:29:15 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: ext3: i_blocks is xx, should be yy
Message-ID: <20020421162915.GA28414@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an (otherwise clean, and cleanly unmounted) ext3 partition, I got
some ext2fs errors like the following:

Inode 295208, i_blocks is 112, should be 8.  Fix<y>?
Inode 295342, i_blocks is 8, should be 0.  Fix<y>?
Inode 295343, i_blocks is 8, should be 0.  Fix<y>?
Inode 295344, i_blocks is 8, should be 0.  Fix<y>?
[...]

I looked up the inodes with debug2fs and noticed that all of them belong
to files which probably had failed write attemps because the fs was
full.

This happened with 2.4.18-rc2-ac1, neither the latest one nor a
'release' version, but I don't remember reading about such a problem on
linux-kernel.

Jan

