Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUA2RXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUA2RXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 12:23:12 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:25241 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266293AbUA2RXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 12:23:10 -0500
Subject: SysV shm device number
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1075388721.15653.124.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Jan 2004 10:05:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to reliably identify SysV shared memory
in the /proc/*/maps files. On one system, the entries
look like this:

40014000-40015000 r--s 00000000 00:04 0          /SYSV00000000 (deleted)
40015000-40016000 rw-s 00000000 00:04 32769      /SYSV000000ff (deleted)

On my system, they look like this:

30016000-30017000 r--s 00000000 00:06 870318096  /SYSV00000000\040(deleted)
30017000-30018000 rw-s 00000000 00:06 870350865  /SYSV000000ff\040(deleted)

So the key number is in the name, and the shmid
number is the inode number. The device major number
is 0, and the device minor number is 4 or 6.

Other than by creating my own SysV shared memory,
is there a way to tell what the minor number
should be?


