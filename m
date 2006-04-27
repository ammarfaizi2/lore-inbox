Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWD0UR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWD0UR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWD0UR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:17:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:18103 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030216AbWD0URZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:17:25 -0400
Date: Thu, 27 Apr 2006 13:15:58 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core fixes for 2.6.17-rc3
Message-ID: <20060427201558.GA2101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver core fixes for 2.6.17-rc1.  They contain the
following changes:
	- documentation update
	- remove frame buffer sysfs file as it no longer works at all
	  due to sysfs core change (this is intentional, the file should
	  be a binary sysfs file not a text one.)
	- fix a build issue for DEBUGFS
	- fix a build issue for different CONFIG_HOTPLUG and CONFIG_NET
	  values.
	- remove some unused kobject exports.

All of these patches have been in the -mm tree for a number of weeks.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h


 Documentation/HOWTO     |    3 +
 drivers/video/fbsysfs.c |   92 +-----------------------------------------------
 include/linux/debugfs.h |    5 +-
 include/linux/kobject.h |    3 -
 lib/kobject.c           |    7 +--
 lib/kobject_uevent.c    |    8 +++-
 6 files changed, 17 insertions(+), 101 deletions(-)

---------------

Adrian Bunk:
      Kobject: possible cleanups

Jean Delvare:
      Fix OCFS2 warning when DEBUG_FS is not enabled

Jon Smirl:
      Frame buffer: remove cmap sysfs interface

Kay Sievers:
      Kobject: fix build error

Paolo Ciarrocchi:
      Added URI of "linux kernel development process"

