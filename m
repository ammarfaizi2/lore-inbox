Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423331AbWJSMVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423331AbWJSMVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423330AbWJSMVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:21:39 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:31449 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1423329AbWJSMVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:21:38 -0400
Subject: warning from i_size_write() 2.6.19-rc2-mm1
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 19 Oct 2006 05:21:36 -0700
Message-Id: <1161260497.11264.4.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got an interesting trace during bootup,

checking if image is initramfs... it is
BUG: warning at fs/inode.c:1389/i_size_write()
 [<c0104126>] show_trace_log_lvl+0x26/0x40
 [<c010425b>] show_trace+0x1b/0x20
 [<c0104c22>] dump_stack+0x22/0x30
 [<c017ef14>] i_size_write+0x64/0x70
 [<c0187cd9>] simple_commit_write+0x79/0xb0
 [<c0172584>] __page_symlink+0xa4/0x1a0
 [<c01726b1>] page_symlink+0x31/0x40
 [<c01cecb6>] ramfs_symlink+0x56/0xe0
 [<c0173213>] vfs_symlink+0x83/0x110
 [<c01759d5>] sys_symlinkat+0xb5/0xe0
 [<c0175a21>] sys_symlink+0x21/0x30
 [<c04fad18>] do_symlink+0x48/0x80
 [<c04fa5dc>] write_buffer+0x2c/0x40
 [<c04fa69a>] flush_window+0x9a/0xf0
 [<c04fac12>] inflate_codes+0x522/0x550
 [<c04fbdd2>] inflate_dynamic+0x632/0x890
 [<c04fc8d7>] unpack_to_rootfs+0x757/0x900
 [<c04fcd70>] populate_rootfs+0xe0/0x100
 [<c01004ac>] init+0xec/0x350
 [<c0103fc3>] kernel_thread_helper+0x7/0x14
 =======================
Freeing initrd memory: 1207k freed


