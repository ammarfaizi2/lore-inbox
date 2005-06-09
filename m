Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVFIWVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVFIWVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVFIWVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:21:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:60617 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262488AbVFIWVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:21:43 -0400
Date: Thu, 9 Jun 2005 15:20:33 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       nsankar@broadcom.com
Subject: [GIT PATCH] Another PCI fix for 2.6.12-rc6
Message-ID: <20050609222033.GA12580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Narendra from Broadcom pointed out that the following patch had not made
it into your tree (it was in mine for a long time, along with the -mm
releases).  It is needed for 2.6.12 because:
	"Broadcom already submitted the bnx2 driver for the 5706 gigabit
	driver which enables MSI on all systems that support PCI-X. That
	patch has already gone into 2.6.12-rc6. So if the MSI disable
	patch does not get into 2.6.12, anyone who uses the 5706 on the
	Serverworks chipset platform, will have interrupt failures."

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patch will be sent to the linux-kernel and linux-pci mailing
lists, if anyone wants to see them.

thanks,

greg k-h

 drivers/pci/quirks.c |    6 ++++++
 1 files changed, 6 insertions(+)

-----

Narendra Sankar:
  PCI: MSI functionality broken on Serverworks GC chipset

