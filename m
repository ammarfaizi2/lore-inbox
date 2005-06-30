Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVF3GCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVF3GCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVF3GCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:02:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:38283 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262858AbVF3GCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:02:17 -0400
Date: Wed, 29 Jun 2005 23:02:06 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver core patches for 2.6.13-rc1
Message-ID: <20050630060206.GA23321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some small patches for the driver core.  They fix a bug that
has caused some people to see deadlocks when some drivers are unloaded
(like ieee1394), and add the ability to bind and unbind drivers from
devices from userspace (something that people have been asking for for a
long time.)

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

thanks,

greg k-h

 drivers/base/base.h    |    1 
 drivers/base/bus.c     |  117 +++++++++++++++++++++++++++++++++++++++++--------
 drivers/base/core.c    |    2 
 drivers/base/dd.c      |    2 
 drivers/base/driver.c  |   35 ++++++++++++++
 include/linux/device.h |    7 ++
 6 files changed, 143 insertions(+), 21 deletions(-)

--------------------

Cornelia Huck:
  driver core: add bus_find_device & driver_find_device functions

Greg Kroah-Hartman:
  driver core: Add the ability to bind drivers to devices from userspace
  driver core: change bus_rescan_devices to return void
  driver core: Add the ability to unbind drivers to devices from userspace

Patrick Mochel:
  Driver core: Use klist_del() instead of klist_remove().

