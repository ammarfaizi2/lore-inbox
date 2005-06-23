Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVFWGLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVFWGLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVFWGLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:11:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:34437 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262166AbVFWGJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:09:40 -0400
Date: Wed, 22 Jun 2005 23:09:34 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, stelian@popies.net,
       linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] 2 small Driver core fixes for 2.6.12-git
Message-ID: <20050623060933.GA11578@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's two patches that fixes some oopses with the USB code due to a
change in the driver core (could also cause problems with other
subsystems, just happened to notice it in the USB code.)  Many thanks to
Stelian Pop for noticing this and figuring out the fix for it.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

thanks,

greg k-h

 drivers/base/bus.c           |    5 ++---
 drivers/usb/input/hid-core.c |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

------

Greg Kroah-Hartman:
  driver core: Fix up the device_attach() error handling in bus_add_device()

Stelian Pop:
  USB: fix hid core to return proper error code from probe

