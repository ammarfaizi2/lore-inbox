Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUCWSzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 13:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbUCWSze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 13:55:34 -0500
Received: from viefep14-int.chello.at ([213.46.255.13]:42335 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S262675AbUCWSzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 13:55:31 -0500
Date: Tue, 23 Mar 2004 19:55:29 +0100
From: Andreas Theofilu <andreas@TheosSoft.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.4: Bug in JFS file system?
Message-Id: <20040323195529.2ac9a207.andreas@TheosSoft.net>
Organization: Theos Soft
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all,

Since kernel 2.6.4 I'm not able to access files with a special character
in the file name, such as the german umlaute. Every attempt to access such
a file gives me the error: cannot stat file

I'm using several partitions with JFS file system and had never seen such
a strange behavior before. The relevant kernel settings are at the bottom
of the mail.

I already unmounted the partition and run fsck on it (fsck.jfs -f
/dev/hda8), but it told me that everything is ok and I'm still not able to
access this files. Also a reboot of the machine didn't change anything. I
booted 2.6.3 again and renamed the files in question (no more special
characters in the file name). Now I can access these files with 2.6.4
also.

Allthough I'm a programmer, I'm not a kernel hacker and don't know where
to start looking for this problem. Could anybody give me a hint where to
start looking?

-------------------------
Kernel 2.6.4 settings (.config)
#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=y
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y

-- 
Andreas Theofilu
http://www.TheosSoft.net/

                     --==| Enjoy the science of Linux! |==--
