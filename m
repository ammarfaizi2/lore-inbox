Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUA0MfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 07:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUA0MfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 07:35:16 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:23200 "EHLO
	albatross-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id S263539AbUA0MfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 07:35:11 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Tue, 27 Jan 2004 12:02:10 +0100 (MET)
Message-Id: <200401271102.i0RB2Ae21718@duna48.eth.ericsson.se>
To: avf-fuse-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] FUSE 1.1-pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the next (and hopefully the last) prerelease version to 1.1.

The biggest change is that NFS export of a FUSE filesystem is now
supported under linux 2.6.X.  Since 2.4 has an inferior NFS export
interface it would be much more difficult to support it.  But who
wants to use 2.4 anyway :)

The other change is that small (4k) reads are now the default again.
This is because there is some overhead with 64k reads (a memory
allocation and an extra memory copy).  Of course if your filesystem
handles big reads more efficiently, then 64k reads may come out
better.  This can be controlled with the '-l' option of fusermount,
passed to the fuse_mount() function or if using fuse_main() this also
works:

  fuseprog /mnt/xyz -- -l

You can download it from here:

  http://sourceforge.net/project/showfiles.php?group_id=21636&package_id=31956&release_id=212701

Please test this release, as this will be 1.1 if no problems are
found!

Thanks,
Miklos
