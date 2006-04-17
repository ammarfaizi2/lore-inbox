Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWDQVa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWDQVa6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWDQVa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:30:57 -0400
Received: from mail.suse.de ([195.135.220.2]:30405 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751316AbWDQVaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:30:55 -0400
Date: Mon, 17 Apr 2006 14:29:46 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Fixes in the -stable tree, but not in mainline
Message-ID: <20060417212946.GA3118@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 5 patches that are in the -stable tree, yet not currently fixed
in your mainline tree.  One of them is a security fix, so it probably
would be a good idea to get it into there :)

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/stable-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/stable-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/block/cciss.c       |   96 ++++++++++++++++++++++----------------------
 drivers/usb/storage/Kconfig |    3 -
 fs/ext3/resize.c            |    1 
 fs/partitions/check.c       |    5 ++
 ipc/shm.c                   |    2 
 5 files changed, 59 insertions(+), 48 deletions(-)

---------------

Ananiev, Leonid I:
      ext3: Fix missed mutex unlock

Hugh Dickins:
      shmat: stop mprotect from giving write permission to a readonly attachment (CVE-2006-1524)

Mike Miller:
      cciss: bug fix for crash when running hpacucli

Randy Dunlap:
      isd200: limit to BLK_DEV_IDE

Stephen Rothwell:
      Fix block device symlink name

