Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVBVMKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVBVMKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVBVMKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:10:05 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:53198 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262277AbVBVMJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:09:56 -0500
Date: Tue, 22 Feb 2005 13:09:55 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch 0/6] Bind Mount Extensions 0.06
Message-ID: <20050222120955.GA3682@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew! Al! Folks!

The following set of patches extends the per device 
'noatime', 'nodiratime' and last but not least the 
'ro' (read only) mount option to the vfs --bind mounts, 
allowing them to behave like any other mount, by 
honoring those mount flags (which are silently ignored 
by the current implementation in 2.4.x and 2.6.x)   	

the patch makes the following syscall variations behave 
as expected:

 - open (read/write/trunc), create
 - link, symlink, unlink
 - mknod (reg/block/char/fifo)
 - mkfifo, mkdir, rmdir, rename
 - (f,l)chown, (f)chmod, utime
 - access, truncate, mmap
 - ioctl (gen/ext2/ext3/reiser)
 - (f,l)setxattr, (f,l)removexattr

an older version of this patch was included in 
2.6.0-test6-mm2, and v2.6.4-wolk2.0, the patches were
used by several people, without any issues ...

please consider inclusion (in -mm ?) and/or let me know
what needs to be changed to get this functionality into
mainline ...

patches are against 2.6.11-rc4 but they do apply fine
against 2.6.11-rc4-bk9 (so no modification required)

TIA,
Herbert

(all six patches are)

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

