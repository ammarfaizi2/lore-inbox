Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbUBIXNn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUBIXNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:13:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:50105 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265357AbUBIXNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:13:41 -0500
Date: Mon, 9 Feb 2004 15:13:25 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core update for 2.6.3-rc1
Message-ID: <20040209231325.GC2393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few driver core changes for 2.6.3-rc1.  The big one here is
the cdev changes which make that interface a lot simpler to use.  These
changes have all been in the past few -mm trees with no problems.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/class.c         |   25 +++++++------------------
 drivers/base/class_simple.c  |   22 +++++++++++++++++++---
 drivers/base/core.c          |   23 -----------------------
 drivers/char/tty_io.c        |    1 -
 drivers/ieee1394/amdtp.c     |    1 -
 drivers/ieee1394/dv1394.c    |    1 -
 drivers/ieee1394/raw1394.c   |    1 -
 drivers/ieee1394/video1394.c |    1 -
 drivers/scsi/sg.c            |    1 -
 drivers/scsi/st.c            |    4 ----
 fs/char_dev.c                |    7 ++++---
 include/linux/cdev.h         |    4 ++--
 include/linux/device.h       |    4 ++--
 lib/kobject.c                |    3 +++
 14 files changed, 37 insertions(+), 61 deletions(-)
-----


<eugene.teo:eugeneteo.net>:
  o Kobject: export some missing symbols

<jonsmirl:yahoo.com>:
  o Driver core: add hotplug support for class_simple

Greg Kroah-Hartman:
  o Driver Core: fix up list_for_each() calls to list_for_each_entry()
  o Driver core: remove device_unregister_wait() as it's a very bad idea

Jonathan Corbet:
  o Char drivers: cdev_unmap()

