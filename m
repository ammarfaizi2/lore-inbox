Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUEXVDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUEXVDV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUEXVDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:03:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:48615 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263340AbUEXVDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:03:19 -0400
Date: Mon, 24 May 2004 14:01:46 -0700
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040524210146.GA5532@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that the ACPI portion of PCI Express support is in the 2.4 kernel
tree, I can send you the remaining portion to actually enable this
feature to work properly.  Here is the PCI Express support for i386 and
x86_64 platforms backported from 2.6 to the 2.4 kernel.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/pci-2.4

The raw patches will follow, for those who want to see them.

thanks,

greg k-h


 Documentation/Configure.help    |   13 +-
 arch/i386/config.in             |    4 
 arch/i386/kernel/Makefile       |    4 
 arch/i386/kernel/mmconfig.c     |  178 ++++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/pci-i386.h     |   10 ++
 arch/i386/kernel/pci-pc.c       |   38 ++++++++
 arch/x86_64/config.in           |   11 ++
 arch/x86_64/kernel/Makefile     |    4 
 arch/x86_64/kernel/mmconfig.c   |  170 ++++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/pci-pc.c     |   46 ++++++++++
 arch/x86_64/kernel/pci-x86_64.h |    9 ++
 drivers/acpi/Config.in          |    2 
 drivers/pci/pci.c               |   23 +++++
 drivers/pci/proc.c              |   23 ++---
 include/asm-i386/fixmap.h       |    3 
 include/asm-x86_64/fixmap.h     |    3 
 include/linux/pci.h             |    1 
 17 files changed, 521 insertions(+), 21 deletions(-)
-----

<blujuice:us.ibm.com>:
  o PCI: PCI Express help in 2.4

Dely Sy:
  o PCI: PCI Express for 2.4

