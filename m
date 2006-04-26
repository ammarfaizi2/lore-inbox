Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWDZBsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWDZBsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 21:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWDZBsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 21:48:36 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:42384 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932332AbWDZBsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 21:48:36 -0400
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][0/21]extend file size and filesystem size
Message-Id: <20060426104827sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Wed, 26 Apr 2006 10:48:27 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, 13 Apr 2006 12:20:28 -0400, Theodore Ts'o wrote:
> Generalized NACK.  We can't just blindly change function signatures
> of pre-existing functions in libext2fs, since this breaks the ABI
> with pre-existing applications linked with current shared libraries
> of libext2fs.

I see.

Since I updated the following 4 patches, please replace old patches
with new ones.

These patches are against e2fsprogs-1.39-WIP-2006-04-09.

  [13/21] modify format strings in print
          - change the format strings "%d" and "%ld" to "%u" and "%lu"
            respectively.

  [14/21] change the type of variables for a block or an inode
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Cast the type of operation in which an overflow occurs to
            long long.

  [15/21] add new functions which manipulate bitmap with 64-bit blk64_t
          - add new functions, which use 64-bit blk64_t and manipulate
            bitmap, leaving existing functions as they are.

  [16/21] enlarge file size and filesystem size
          - Add new option "-O large_block" in mke2fs.

          - With this option, the maximum size of a file is (blocksize)
            * (2^32-1) bytes, and of a filesystem is (pagesize) *
           (2^32-1).

Any feedback and comments are welcome.

Cheers, sho
