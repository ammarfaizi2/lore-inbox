Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTDIBGl (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbTDIBGl (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:06:41 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:35273 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261916AbTDIBGj (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 21:06:39 -0400
Date: Wed, 9 Apr 2003 02:18:02 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.67 - reiserfs go boom.
Message-ID: <20030409011802.GD25834@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst running fsx.. (Though fsx didn't trigger any error,
and is still running)..

		Dave

buffer layer error at fs/buffer.c:127
Call Trace:
 [<c016d260>] __wait_on_buffer+0xd0/0xe0
 [<c0121760>] autoremove_wake_function+0x0/0x50
 [<c0121760>] autoremove_wake_function+0x0/0x50
 [<c02886c8>] reiserfs_unmap_buffer+0x68/0xa0
 [<c0288768>] unmap_buffers+0x68/0x70
 [<c0288948>] indirect2direct+0x1d8/0x2b0
 [<c0286584>] reiserfs_cut_from_item+0x3d4/0x4e0
 [<c0286955>] reiserfs_do_truncate+0x265/0x520
 [<c0170e12>] block_prepare_write+0x32/0x50
 [<c027446a>] reiserfs_truncate_file+0x15a/0x3b0
 [<c028cfc7>] journal_end+0x27/0x30
 [<c0275f2c>] reiserfs_file_release+0x39c/0x600
 [<c014c9bb>] check_poison_obj+0x3b/0x1b0
 [<c014e934>] kmem_cache_alloc+0x124/0x170
 [<c016c711>] get_empty_filp+0x51/0x100
 [<c016c9a1>] __fput+0xf1/0x100
 [<c016ab3a>] filp_close+0x15a/0x230
 [<c01833a3>] do_fcntl+0xe3/0x1c0
 [<c0182ebc>] sys_dup2+0xec/0x130
 [<c010a457>] syscall_call+0x7/0xb


