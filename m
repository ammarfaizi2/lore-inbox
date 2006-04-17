Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWDQMas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWDQMas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 08:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWDQMas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 08:30:48 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:4529 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750798AbWDQMas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 08:30:48 -0400
Message-ID: <020501c6621a$bf158c50$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: <linux-kernel@vger.kernel.org>, <Ext2-devel@lists.sourceforge.net>
References: <20060413161227sho@rifu.tnes.nec.co.jp> <20060413162028.GA23452@thunk.org>
Subject: Re: [Ext2-devel] [RFC][15/21]e2fsprogs modify variables for bitmap to exceed 2G
Date: Mon, 17 Apr 2006 21:30:39 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment, Ted.

> Generalized NACK.  We can't just blindly change function signatures of
> pre-existing functions in libext2fs, since this breaks the ABI with
> pre-existing applications linked with current shared libraries of
> libext2fs.

Though I checked if there are any commands which use the following
functions in RHEL4, no such commands were found except in e2fsprogs
itself.

ext2fs_allocate_generic_bitmap()
ext2fs_fudge_block_bitmap_end()
ext2fs_warn_bitmap()
ext2fs_test_generic_bitmap()
ext2fs_mark_block_bitmap()
ext2fs_unmark_block_bitmap()
ext2fs_test_block_bitmap()
ext2fs_fast_test_block_bitmap_range()
ext2fs_mark_block_bitmap_range()
ext2fs_fast_mark_block_bitmap_range()
ext2fs_unmark_block_bitmap_range()
ext2fs_fast_unmark_block_bitmap_range()
ext2fs_mark_generic_bitmap()
ext2fs_unmark_generic_bitmap()
ext2fs_resize_generic_bitmap()
ext2fs_resize_block_bitmap()

So I think changing these function signatures does not break the ABI
practically.  Am I missing something?

Cheers, sho
