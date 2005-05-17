Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVEQEw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVEQEw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEQEw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:52:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:53379 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261684AbVEQEwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:52:19 -0400
Date: Mon, 16 May 2005 21:52:16 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB bugfixes for 2.6.12-rc4
Message-ID: <20050517045215.GA17567@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 4 patches for the 2.6.12-rc4 tree that fix some USB bugs, and
make it easier for userspace to autoload modules for USB devices.  All
of these patches have been in the past few -mm releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

Full patches will be sent to the linux-usb-devel mailing list, if anyone
wants to see them.

thanks,

greg k-h

 drivers/usb/core/sysfs.c        |   34 +++++++++++++++++++++++++
 drivers/usb/host/ehci-hub.c     |    1 
 drivers/usb/net/Kconfig         |   12 ++++++---
 drivers/usb/net/usbnet.c        |   53 +++++++++++++++++++---------------------
 drivers/usb/serial/cypress_m8.c |    2 +
 drivers/usb/serial/cypress_m8.h |    1 
 6 files changed, 72 insertions(+), 31 deletions(-)

David Brownell:
  o USB: ehci suspend must stop timer
  o USB: usbnet driver fixes

Greg Kroah-Hartman:
  o USB: add modalias sysfs file for usb devices

Lonnie Mendez:
  o USB: cypress_m8: add support for the DeLorme Earthmate lt-20

