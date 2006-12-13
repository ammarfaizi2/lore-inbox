Return-Path: <linux-kernel-owner+w=401wt.eu-S1751754AbWLMXlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWLMXlK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWLMXlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:41:10 -0500
Received: from mx1.suse.de ([195.135.220.2]:33148 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbWLMXlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:41:09 -0500
Date: Wed, 13 Dec 2006 15:40:47 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061213234047.GA14675@suse.de>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <20061213203113.GA9026@suse.de> <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 12:58:24PM -0800, Linus Torvalds wrote:
> I'm really not convinced about the user-mode thing unless somebody can 
> show me a good reason for it. Not just some "wouldn't it be nice" kind of 
> thing. A real, honest-to-goodness reason that we actually _want_ to see 
> used.
> 
> No features just for features sake.

Ok, Thomas just showed at least one example of where this interface is a
big advantage over the all-in-kernel model.  I'll work with him and try
to dig up other real examples before submitting this code again.

In the mean time, I'll leave it in my tree and it will get some more
exposure in the -mm releases.

> So please push the tree without this userspace IO driver at all.

Done.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

It contains the changes listed below.

thanks,

greg k-h


 drivers/base/class.c            |    2 ++
 drivers/base/platform.c         |    4 ++--
 fs/debugfs/inode.c              |   39 ++++++++++++++++++++++++++++++---------
 include/linux/platform_device.h |    2 +-
 kernel/module.c                 |   25 +++++++++++++++++++++++++
 kernel/power/Kconfig            |    9 +++++----
 6 files changed, 65 insertions(+), 16 deletions(-)

---------------

Akinobu Mita (1):
      driver core: delete virtual directory on class_unregister()

Andrew Morton (1):
      Driver core: "platform_driver_probe() can save codespace": save codespace

David Brownell (1):
      Driver core: deprecate PM_LEGACY, default it to N

Kay Sievers (1):
      Driver core: show "initstate" of module

Mathieu Desnoyers (5):
      DebugFS : inotify create/mkdir support
      DebugFS : coding style fixes
      DebugFS : file/directory creation error handling
      DebugFS : more file/directory creation error handling
      DebugFS : file/directory removal fix

Scott Wood (1):
      Driver core: Make platform_device_add_data accept a const pointer

