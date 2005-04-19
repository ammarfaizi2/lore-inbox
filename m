Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVDSTt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVDSTt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVDSTt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:49:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:7563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261643AbVDSTtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:49:16 -0400
Date: Tue, 19 Apr 2005 12:47:30 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-ID: <20050419194728.GA24367@kroah.com>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 12:40:44PM -0700, Linus Torvalds wrote:
> I'm still working out some performance issues with merges (the actual
> "merge" operation itself is very fast, but I've been trying to make the
> subsequent "update the working directory tree to the right thing" be much
> better).

Ok, if you want some practice with "real" merges, feel free to merge from
the following two trees whenever you are ready:
	kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
for 11 aoe bugfix patches, and:
	kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
for 13 driver core, sysfs, and debugfs fixes.

The diffstats are:

aoe:
 Documentation/aoe/mkdevs.sh       |    1 
 Documentation/aoe/mkshelf.sh      |    1 
 Documentation/aoe/todo.txt        |   14 ++++
 Documentation/aoe/udev-install.sh |    6 +-
 drivers/block/aoe/aoe.h           |   23 +++++--
 drivers/block/aoe/aoeblk.c        |    5 +
 drivers/block/aoe/aoecmd.c        |  110 ++++++++++++++++++++++----------------
 drivers/block/aoe/aoedev.c        |    8 +-
 drivers/block/aoe/aoenet.c        |    8 +-
 9 files changed, 111 insertions(+), 65 deletions(-)

driver:
 Documentation/kref.txt        |  221 +++++++++++++++++++++++++++++++++++++++++-
 drivers/base/class.c          |    2 
 drivers/base/core.c           |    3 
 drivers/base/firmware_class.c |    3 
 drivers/base/platform.c       |    1 
 drivers/usb/host/hc_crisv10.c |    1 
 fs/partitions/check.c         |    2 
 fs/sysfs/file.c               |   35 ++++++
 include/linux/debugfs.h       |   14 +-
 include/linux/sysfs.h         |    7 +
 lib/kobject.c                 |    7 -
 net/bridge/br_sysfs_if.c      |    2 
 scripts/ver_linux             |    2 
 13 files changed, 290 insertions(+), 10 deletions(-)

No rush, but they should be good test for your merge speeds, as they are
based off of an older HEAD than your current one :)

> In other words, I want it to be at the point where people can do
> 
> 	git pull <repo-address>
> 
> and it will "just work", at least for people who don't have any local
> changes in their tree. None of this "check out all the files again" crap.

That would be very nice to have.

> But how about a plan that we go "live" tomorrow - assuming nobody finds
> any problems before that, of course.

That's fine with me.

thanks,

greg k-h
