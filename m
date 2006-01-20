Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWATGGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWATGGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWATGGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:06:43 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:29393
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030322AbWATGGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:06:42 -0500
Date: Thu, 19 Jan 2006 22:06:32 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] W1 patches for 2.6.16-rc1
Message-ID: <20060120060632.GA9951@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some w1 patches that have been in the -mm tree for a long time.
They move some files into different locations, add a new driver, and fix
some bugs.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/w1-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/w1/masters/ds2482   |   31 +
 drivers/w1/Kconfig                |   60 --
 drivers/w1/Makefile               |   10 
 drivers/w1/ds_w1_bridge.c         |  208 ---------
 drivers/w1/dscore.c               |  795 --------------------------------------
 drivers/w1/dscore.h               |  166 -------
 drivers/w1/masters/Kconfig        |   50 ++
 drivers/w1/masters/Makefile       |   13 
 drivers/w1/masters/ds2482.c       |  564 ++++++++++++++++++++++++++
 drivers/w1/masters/ds_w1_bridge.c |  174 ++++++++
 drivers/w1/masters/dscore.c       |  795 ++++++++++++++++++++++++++++++++++++++
 drivers/w1/masters/dscore.h       |  166 +++++++
 drivers/w1/masters/matrox_w1.c    |  247 +++++++++++
 drivers/w1/matrox_w1.c            |  261 ------------
 drivers/w1/slaves/Kconfig         |   38 +
 drivers/w1/slaves/Makefile        |   12 
 drivers/w1/slaves/w1_ds2433.c     |  329 +++++++++++++++
 drivers/w1/slaves/w1_smem.c       |   71 +++
 drivers/w1/slaves/w1_therm.c      |  268 ++++++++++++
 drivers/w1/w1.c                   |   21 -
 drivers/w1/w1.h                   |   34 +
 drivers/w1/w1_ds2433.c            |  329 ---------------
 drivers/w1/w1_family.c            |    2 
 drivers/w1/w1_int.c               |   15 
 drivers/w1/w1_io.c                |    2 
 drivers/w1/w1_smem.c              |   71 ---
 drivers/w1/w1_therm.c             |  268 ------------
 27 files changed, 2823 insertions(+), 2177 deletions(-)


Adrian Bunk:
      W1: misc cleanups
      W1: fix W1_MASTER_DS9490_BRIDGE dependencies

Andrew Morton:
      W1: u64 is not long long

Evgeniy Polyakov:
      W1: Move w1 bus master code into 'w1/masters' and move w1 slave code into 'w1/slaves'
      W1: Add the DS2482 I2C-to-w1 bridge driver.
      W1: Change the type 'unsigned long' member of 'struct w1_bus_master' to 'void *'.

Patrick McHardy:
      W1: Remove incorrect MODULE_ALIAS

