Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424617AbWKQAHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424617AbWKQAHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424620AbWKQAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:07:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:65435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1424617AbWKQAHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:07:51 -0500
Date: Thu, 16 Nov 2006 16:07:40 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Misc Driver fixes for 2.6.19-rc6
Message-ID: <20061117000740.GB687@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver related fixes for 2.6.19-rc6.

Three patches here:
	- aoe bugfix that is on Adrian's list.
	- w1 bugfix to prevent a memory leak
	- debugfs fix to properly detect errors

All of these patches have been in the -mm tree for a quite a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h

 drivers/block/aoe/aoeblk.c     |    1 +
 drivers/w1/masters/matrox_w1.c |    2 ++
 fs/debugfs/inode.c             |    4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

---------------

Akinobu Mita (1):
      debugfs: check return value correctly

Amol Lad (1):
      W1: ioremap balanced with iounmap

Dennis Stosberg (1):
      aoe: Add forgotten NULL at end of attribute list in aoeblk.c

