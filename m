Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVEJPRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVEJPRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVEJPRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:17:25 -0400
Received: from schlund.terranet.ro ([80.96.218.84]:42302 "EHLO
	dizzywork.schlund.ro") by vger.kernel.org with ESMTP
	id S261683AbVEJPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:15:33 -0400
Message-ID: <4280D011.8080302@schlund.ro>
Date: Tue, 10 May 2005 18:15:29 +0300
From: Mihai Rusu <dizzy@schlund.ro>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Robert Love <rml@novell.com>
Subject: [RFC][PATCH 2.4 4/4] inotify 0.22 2.4.x backport - main inotify codes
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This are the inotify specific codes and the bulk of this backport.
Because the patch exceeds 40Kbytes I am posting it on a web site.

http://oss.schlund.de/inotify-2.4/04_inotify-2.4.30.patch

 Documentation/00-INDEX                |    2
 Documentation/Configure.help          |   12
 Documentation/filesystems/inotify.txt |   81 ++
 fs/Config.in                          |    2
 fs/Makefile                           |    3
 fs/attr.c                             |   34 -
 fs/file_table.c                       |    3
 fs/inode.c                            |   16
 fs/inotify.c                          | 1033
++++++++++++++++++++++++++++++++++
 fs/namei.c                            |  140 ++--
 fs/open.c                             |    7
 fs/read_write.c                       |   25
 include/linux/fs.h                    |    5
 include/linux/fsnotify.h              |  230 +++++++
 include/linux/inotify.h               |  113 +++
 include/linux/sched.h                 |    5
 kernel/user.c                         |    4
 17 files changed, 1595 insertions(+), 120 deletions(-)

-- 
Mihai Rusu
Linux System Development

Schlund + Partner AG   Tel         : +40-21-231-2544
Str Mircea Eliade 18   EMail       : dizzy@schlund.ro
Sect 1, Bucuresti
71295, Romania



