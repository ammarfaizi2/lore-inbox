Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUINJ4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUINJ4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269249AbUINJ4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:56:00 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:22247 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269250AbUINJzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:55:42 -0400
From: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Organization: -ENOENT
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm5
Date: Tue, 14 Sep 2004 12:00:36 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org>
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409141200.36074.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 10:50, Andrew Morton wrote:
> Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
>
>  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
>
> and will later appear at
>
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6
>.9-rc1-mm5/

100% reproducible under heavy IO load:

Sep 14 11:42:59 odyssey kernel: journal_bmap: journal block not found at 
offset 2060 on hda12
Sep 14 11:42:59 odyssey kernel: Aborting journal on device hda12.
Sep 14 11:42:59 odyssey kernel: EXT3-fs error (device hda12) in 
ext3_dirty_inode: IO failure
Sep 14 11:43:00 odyssey kernel: ext3_abort called.
Sep 14 11:43:00 odyssey kernel: EXT3-fs error (device hda12): 
ext3_journal_start: Detected aborted journal
Sep 14 11:43:00 odyssey kernel: Remounting filesystem read-only
Sep 14 11:43:00 odyssey kernel: ext3_reserve_inode_write: aborting 
transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs 
error (device hda12) in ext3_reserve_inode_write: Journal has aborted
Sep 14 11:43:00 odyssey kernel: ext3_reserve_inode_write: aborting 
transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs 
error (device hda12) in ext3_reserve_inode_write: Journal has aborted
Sep 14 11:43:00 odyssey kernel: EXT3-fs error (device hda12) in 
ext3_orphan_del: Journal has aborted
Sep 14 11:43:00 odyssey kernel: EXT3-fs error (device hda12) in ext3_truncate: 
Journal has aborted
Sep 14 11:43:00 odyssey kernel: EXT3-fs error (device hda12) in 
start_transaction: Journal has aborted
Sep 14 11:43:01 odyssey last message repeated 17 times
Sep 14 11:43:01 odyssey kernel: or (device hda12) in start_transaction: 
Journal has aborted
Sep 14 11:43:01 odyssey kernel: EXT3-fs error (device hda12) in 
start_transaction: Journal has aborted
Sep 14 11:43:02 odyssey last message repeated 53 times
Sep 14 11:43:02 odyssey kernel: EXT3-fs error (device hda12) in staror (device 
hda12) in start_transaction: Journal has aborted
Sep 14 11:43:02 odyssey kernel: EXT3-fs error (device hda12) in 
start_transaction: Journal has aborted
Sep 14 11:43:03 odyssey last message repeated 53 times
Sep 14 11:43:03 odyssey kernel: EXT3-fs error (device hda12) in staror (device 
hda12) in start_transaction: Journal has aborted
Sep 14 11:43:03 odyssey kernel: EXT3-fs error (device hda12) in 
start_transaction: Journal has aborted
Sep 14 11:43:34 odyssey last message repeated 147542 times
