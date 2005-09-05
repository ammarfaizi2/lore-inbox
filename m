Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVIEXcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVIEXcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVIEXcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:32:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:7553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964957AbVIEXcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:32:33 -0400
Date: Mon, 5 Sep 2005 16:32:08 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver core patches for 2.6.13
Message-ID: <20050905233207.GA16560@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches for the driver core for 2.6.13.  They have all
been in the -mm tree for a while and fix a few bugs, and add proper
sysfs support for the floppy driver.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

thanks,

greg k-h

 Documentation/filesystems/sysfs.txt |   30 ++++-----
 drivers/base/bus.c                  |    8 +-
 drivers/base/class.c                |   39 ++++++++++--
 drivers/base/core.c                 |    2 
 drivers/base/dd.c                   |    2 
 drivers/base/sys.c                  |  110 +++++++++++++++++++++++++++---------
 drivers/block/floppy.c              |   57 +++++++++++-------
 drivers/usb/core/hcd.c              |    2 
 include/linux/klist.h               |    8 +-
 lib/klist.c                         |    8 +-
 10 files changed, 187 insertions(+), 79 deletions(-)


Andrew Morton:
  Floppy: add cmos attribute to floppy driver tidy

Dmitry Torokhov:
  Driver core: link device and all class devices derived from it.

Greg Kroah-Hartman:
  Fix manual binding infinite loop

Hannes Reinecke:
  Floppy: Add cmos attribute to floppy driver

James Bottomley:
  klist: fix klist to have the same klist_add semantics as list_head

Jan Veldeman:
  Driver core: Documentation: use S_IRUSR | ... in stead of 0644
  Driver core: Documentation: fix whitespace between parameters

Jesper Juhl:
  Driver core: small cleanup; remove check for NULL before kfree() in driver core

Shaohua Li:
  Driver core: hande sysdev suspend failure

