Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTFJX5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFJX4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:56:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:34960 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262267AbTFJXz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:55:57 -0400
Date: Tue, 10 Jun 2003 17:11:27 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] And yet more PCI fixes for 2.5.70
Message-ID: <20030611001127.GA21057@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

And again, here's some more PCI changes against the latest 2.5.70 bk tree.
They contain the following:
	- removed the last of the usages of pci_present(), and the
	  pci_present() function.
	- added some __user markings to make sparse happy.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/ide/ide.c    |    2 +-
 drivers/pci/proc.c   |    6 +++---
 drivers/pci/search.c |   11 -----------
 drivers/sbus/sbus.c  |    2 +-
 include/linux/pci.h  |    3 ---
 5 files changed, 5 insertions(+), 19 deletions(-)
-----

Greg Kroah-Hartman:
  o PCI: sparse fixups for drivers/pci/proc.c
  o PCI: pci_present() can finally be removed, as there are no more users of it
  o PCI: replace usage of pci_present() in drivers/sbus/sbus.c
  o PCI: fix up usage of pci_present in drivers/ide/ide.c

