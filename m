Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbWBVRnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWBVRnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWBVRnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:43:33 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28575
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1422631AbWBVRnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:43:33 -0500
Date: Wed, 22 Feb 2006 09:43:39 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kay.sievers@suse.de
Subject: [GIT PATCH] Driver Core fixe for 2.6.16-rc4
Message-ID: <20060222174339.GA11415@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a single changeset, backing out the umount/mount uevent removal
from the kernel tree.  It was my fault in the first place for thinking
that this event could be removed, as I was not aware the current version
of HAL depended on it so much.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

The patch will be sent as a follow-up message for those that wish to see
it.

thanks,

greg k-h


 Documentation/feature-removal-schedule.txt |    9 +++++++++
 fs/super.c                                 |   15 ++++++++++++++-
 include/linux/kobject.h                    |    6 ++++--
 lib/kobject_uevent.c                       |    4 ++++
 4 files changed, 31 insertions(+), 3 deletions(-)
