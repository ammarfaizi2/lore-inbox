Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWIAHrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWIAHrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 03:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWIAHrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 03:47:24 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:65257 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750730AbWIAHrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 03:47:23 -0400
Date: Fri, 1 Sep 2006 09:42:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 01/22][RFC] Unionfs: Documentation
In-Reply-To: <20060901013729.GB5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609010937270.25521@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901013729.GB5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


nice to see that unionfs finally tries to get in :)


>+Whiteouts:
>+==========
>+
>+A whiteout removes a file name from the name-space. Whiteouts are needed when
>+one attempts to remove a file on a read-only branch.

"namespace".

>+Suppose we have a two branch union, where branch 0 is read-write and branch 1

I'd go for "two-branch".

>+Copyup:
>+=======
>+
>+When a change is made to the contents of a file's data or meta-data, they
>+have to be stored somewhere. The best way is to create a copy of the
>+original file on a branch that is writable, and then redirect the write
>+though to this copy. The copy must be made on a higher priority branch so
>+that lookup & readdir return this newer "version" of the file rather than
>+the original (see duplicate elimination).

Apropos copyup, sparse copyup would probably a nice feature in future, but it
also has its effects.

>--- linux-2.6-git/Documentation/filesystems/unionfs/usage.txt	1969-12-31 19:00:00.000000000 -0500
>+++ linux-2.6-git-unionfs/Documentation/filesystems/unionfs/usage.txt	2006-08-31 19:25:19.000000000 -0400
>+
>+mount -t unionfs -o branch-option[,union-options[,...]] none unionfs

should read
mount -t unionfs -o branch-option[,union-options[,...]] none MOUNTPOINT

>+KNOWN ISSUES:
>+=============
>+
>+The NFS server returns -EACCES for read-only exports, instead of -EROFS.  This

Will the NFS code ever be changed to return EROFS instead?

>+nfs-mouted branch.

mounted

>+Modifying a Unionfs branch directly, while the union is mounted is currently
>+unsupported.  Any such change can cause Unionfs to oops, however it could even
>+BRESULT IN DATA LOSS.

RESULT




Jan Engelhardt
-- 
