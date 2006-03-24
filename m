Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422665AbWCXBaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWCXBaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422965AbWCXBaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:30:16 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11748
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1422665AbWCXBaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:30:14 -0500
Date: Thu, 23 Mar 2006 17:29:54 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] W1 patches for 2.6.16
Message-ID: <20060324012954.GA17389@kroah.com>
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

 Documentation/w1/masters/ds2482   |   31 ++
 drivers/w1/Kconfig                |   60 ----
 drivers/w1/Makefile               |   10 
 drivers/w1/masters/Kconfig        |   48 +++
 drivers/w1/masters/Makefile       |   13 
 drivers/w1/masters/ds2482.c       |  564 ++++++++++++++++++++++++++++++++++++++
 drivers/w1/masters/ds_w1_bridge.c |   38 +-
 drivers/w1/masters/dscore.c       |    4 
 drivers/w1/masters/matrox_w1.c    |   22 -
 drivers/w1/slaves/Kconfig         |   38 ++
 drivers/w1/slaves/Makefile        |   12 
 drivers/w1/slaves/w1_ds2433.c     |    8 
 drivers/w1/slaves/w1_smem.c       |   10 
 drivers/w1/slaves/w1_therm.c      |   14 
 drivers/w1/w1.c                   |   77 +----
 drivers/w1/w1.h                   |   37 +-
 drivers/w1/w1_family.c            |    2 
 drivers/w1/w1_int.c               |   49 ---
 drivers/w1/w1_io.c                |    2 
 19 files changed, 824 insertions(+), 215 deletions(-)

---------------

Adrian Bunk:
      w1: misc cleanups
      fix W1_MASTER_DS9490_BRIDGE dependencies

Andrew Morton:
      W1: u64 is not long long

Evgeniy Polyakov:
      W1: Change the type 'unsigned long' member of 'struct w1_bus_master' to 'void *'.
      W1: Move w1 bus master code into 'w1/masters' and move w1 slave code into 'w1/slaves'
      W1: Add the DS2482 I2C-to-w1 bridge driver.
      w1: use kthread api.

Patrick McHardy:
      W1: Remove incorrect MODULE_ALIAS

