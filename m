Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbTI1PzU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 11:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbTI1PzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 11:55:20 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:64952 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262586AbTI1PzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 11:55:16 -0400
Date: Sun, 28 Sep 2003 17:55:15 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bind Mount Extensions (RO --bind mounts)
Message-ID: <20030928155515.GA4325@DUK2.13thfloor.at>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!

verified that the patches apply on linux-2.6.0-test6
and work as expected ...

FYI, this patch (hopefully) allows RO --bind mounts
to 'behave' like other ro mounted filesystems, and
I hope that they will be included in the mainline
in the near future ;)

AFAIK, it handles the following cases as expected:

 - open (read/write/trunc), create
 - link, symlink, unlink
 - mknod (reg/block/char/fifo), mkfifo
 - mkdir, rmdir
 - (f)chown, (f)chmod, utimes
 - ioctl (gen/ext2/ext3/reiser)
 - access, truncate

it doesn't handle update_atime() yet (Al Viro is still
busy ;) and it doesn't change current intermezzo code
(but this would be easy to add, because it's almost the
same as the vfs_*()s at least regarding ro --bind mounts)

you can get them at:

http://vserver.13thfloor.at/Experimental/patch-2.4.22-rc2-bme0.03.diff
http://vserver.13thfloor.at/Experimental/patch-2.4.22-rc2-bme0.03.diff.bz2
http://vserver.13thfloor.at/Experimental/patch-2.6.0-test3-bme0.03.diff
http://vserver.13thfloor.at/Experimental/patch-2.6.0-test3-bme0.03.diff.bz2

enjoy,
Herbert

