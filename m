Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWGLX1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWGLX1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGLX1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:27:30 -0400
Received: from mail.suse.de ([195.135.220.2]:28044 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932174AbWGLX13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:27:29 -0400
Date: Wed, 12 Jul 2006 16:23:43 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core patches for 2.6.18-rc1
Message-ID: <20060712232343.GA22672@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver core patches and fixes for 2.6.18-rc1.  They
contain the following changes:
	- documentation fixes
	- remove unused functions and symbols

All of these patches have been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h


 Documentation/feature-removal-schedule.txt |    8 ------
 drivers/base/bus.c                         |    5 ++--
 drivers/base/core.c                        |   30 +++++++++++------------
 include/linux/ioport.h                     |    2 +-
 include/linux/pm_legacy.h                  |    7 -----
 kernel/power/pm.c                          |   37 ----------------------------
 kernel/resource.c                          |    2 --
 7 files changed, 19 insertions(+), 72 deletions(-)

---------------

Adrian Bunk:
      Driver core: bus.c cleanups
      remove kernel/power/pm.c:pm_unregister_all()
      The scheduled unexport of insert_resource

Henrik Kretzschmar:
      Driver core: kernel-doc in drivers/base/core.c corrections

Randy Dunlap:
      Driver core: fix driver-core kernel-doc

