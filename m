Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbTHOSZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTHOSZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:25:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:57218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270691AbTHOSZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:25:30 -0400
Date: Fri, 15 Aug 2003 11:25:00 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core fixes for 2.6.0-test3
Message-ID: <20030815182459.GA3755@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some driver core changes that do the following things:
	- remove struct device.name field and fix up remaining
	  subsystems
	- add warnings for programmers who implement driver core code
	  incorrectly.

Pat has approved these changes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/base/power.c          |  140 ------------------------------------------
 drivers/base/class.c          |   14 +++-
 drivers/base/core.c           |   17 +++--
 drivers/base/interface.c      |   96 +++++++---------------------
 drivers/base/platform.c       |    1 
 drivers/base/power.c          |    2 
 drivers/base/power/shutdown.c |   68 ++++++++++++++++++++
 drivers/block/floppy.c        |    6 -
 drivers/ide/ide-probe.c       |    3 
 drivers/media/video/bttv-if.c |    2 
 drivers/pcmcia/i82365.c       |    3 
 drivers/pcmcia/tcic.c         |    3 
 drivers/pcmcia/yenta_socket.c |    2 
 drivers/scsi/scsi_debug.c     |    2 
 drivers/scsi/scsi_scan.c      |   20 ------
 drivers/scsi/scsi_sysfs.c     |    2 
 include/linux/device.h        |   26 +++----
 17 files changed, 131 insertions(+), 276 deletions(-)
-----


Greg Kroah-Hartman:
  o Driver Core: add warnings if .release functions are not set for objects
  o Remove usage of struct device.name from scsi core
  o Remove usage of struct device.name from bttv driver
  o Remove usage of struct device.name from pcmcia layer
  o Remove usage of struct device.name from ide core
  o Remove .name usage from floppy driver
  o Driver Core: remove struct device.name as it is not needed

