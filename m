Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVEQW0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVEQW0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVEQWXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:23:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:30885 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261748AbVEQWLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:11:43 -0400
Date: Tue, 17 May 2005 15:11:39 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core patches for 2.6.12-rc4
Message-ID: <20050517221136.GA29232@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 2 patches for the 2.6.12-rc4 tree that clean up some driver
core stuff.  Both of these patches have been in the -mm tree for a
while.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Full patches will be sent to the linux-kernel mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/filesystems/sysfs-pci.txt |    6 +--
 Documentation/power/devices.txt         |   21 -------------
 Documentation/powerpc/hvcs.txt          |    4 +-
 drivers/base/Makefile                   |    2 -
 drivers/base/bus.c                      |    1 
 drivers/base/core.c                     |    3 -
 drivers/base/interface.c                |   51 --------------------------------
 drivers/base/power/power.h              |   11 ------
 drivers/base/power/resume.c             |   11 ++++++
 drivers/base/power/shutdown.c           |   29 ++++--------------
 drivers/base/power/suspend.c            |   17 +++++++++-
 include/linux/device.h                  |    3 -
 kernel/power/main.c                     |    6 +--
 13 files changed, 40 insertions(+), 125 deletions(-)

David Brownell:
  o Driver Core: remove driver model detach_state
  o Driver Core: pm diagnostics update, check for errors

