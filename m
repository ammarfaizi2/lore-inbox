Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271973AbTHHWMB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272068AbTHHWMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:12:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15027 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S271973AbTHHWL7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:11:59 -0400
Message-ID: <3F341EF4.1F4EC42E@us.ibm.com>
Date: Fri, 08 Aug 2003 17:06:44 -0500
From: "Steve French (IBM LTC)" <smfltc@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, samba-announce@lists.samba.org
Subject: [PATCH] cifs vfs for 2.4 linux kernel updated
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch to apply the current stable version of the CIFS VFS to the 2.4
kernel is available at
http://cvs.samba.org/samba/ftp/cifs-cvs/cifs24.87.patch   The patch only
affects the usual small set of files outside its own directory (fs/cifs)
that a filesystem must change (e.g. fs/Config.in, fs/Makefile,
fs/Config.help) but does not require changes to any core kernel code.

Network filesystem interoperability with some of the newer servers,
including e.g. Windows 2003, requires features such as smb/cifs signing
which only the cifs vfs provides, so it is getting more important to add
the cifs vfs to 2.4 kernels when in heterogeneous environments.

The cifs filesystem is designed as a client network filesysetm for
remote access to Samba, newer Windows servers and also the many common
CIFS based NAS appliances, but unlike smbfs, the cifs vfs is optimized
for the current versions of the SMB/CIFS protocol and has better POSIX
file i/o semantics.   The CIFS file system can coexist with smbfs.   The
project web site has more information on the project
http://us1.samba.org/samba/Linux_CIFS_client.html

The filesystem has been in the 2.5 Linux Kernel for almost a year, and
is included in the the multiple 2.4 kernel distributions.   The version
attached is the current version of the vfs module source for 2.4
(version 0.8.7) and matches the level of the code in the 2.5 kernel as
closely as possible.

