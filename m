Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTI3Wx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTI3Wsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:48:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:38363 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261827AbTI3WrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:24 -0400
Date: Tue, 30 Sep 2003 15:34:36 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.0-test6
Message-ID: <20030930223436.GA21200@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI patches against 2.6.0-test6.  They mainly clean up the
pci power code by removing it entirely, as it is now done by the driver
core.  There are a few other minor janitorial fixes in here too.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/power.c                    |  159 ---------------------------------
 drivers/ide/pci/sc1200.c               |   61 ++++++------
 drivers/net/irda/vlsi_ir.c             |   10 --
 drivers/pci/Makefile                   |    1 
 drivers/pci/hotplug/cpqphp.h           |    1 
 drivers/pci/hotplug/pci_hotplug.h      |    1 
 drivers/pci/hotplug/pci_hotplug_core.c |   15 +--
 drivers/pci/pool.c                     |    1 
 drivers/pci/quirks.c                   |    3 
 drivers/scsi/nsp32.c                   |   10 --
 include/linux/pci.h                    |    1 
 11 files changed, 42 insertions(+), 221 deletions(-)
-----

<lxiep:us.ibm.com>:
  o PCI Hotplug: export hotplug_slots subsys

<rtjohnso:eecs.berkeley.edu>:
  o PCI: __init documetation

Alexey Dobriyan:
  o PCI: Remove setting TASK_RUNNING after schedule_timeout in /drivers/pci/

Patrick Mochel:
  o Remove ->save_state() in sc1200.c
  o Remove ->save_state() from vlsi_ir.c
  o Remove ->save_state() in nsp32.c
  o [pci] Really delete drivers/pci/power.c
  o [pci] Remove ->save_state() from struct pci_driver
  o [pci] Remove drivers/pci/power.c

