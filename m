Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWBIOrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWBIOrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWBIOrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:47:51 -0500
Received: from math.ut.ee ([193.40.36.2]:63183 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932494AbWBIOrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:47:51 -0500
Date: Thu, 9 Feb 2006 16:47:49 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: megaraid bug in kobject_register when no device is present
Message-ID: <Pine.SOC.4.61.0602091646050.19027@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loading megaraid modules when no actual cards are present yields this in 
dmesg. 2.6.16-rc2+git.

megasas: 00.00.02.02 Mon Jan 23 14:09:01 PST 2006
megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.7 (Release Date: Mon Nov 14 12:27:22 EST 2005)
kobject_register failed for megaraid (-17)
  [<b01b0fa1>] kobject_register+0x43/0x5f
  [<b020b5ad>] bus_add_driver+0x51/0xa8
  [<b01bc812>] __pci_register_driver+0x5e/0x89
  [<b011ca7c>] printk+0x17/0x1b
  [<f0e89070>] megaraid_init+0x70/0x98 [megaraid_mbox]
  [<b0136759>] sys_init_module+0x128/0x1bd
  [<b01029a7>] sysenter_past_esp+0x54/0x75
megaraid: could not register hotplug support.

-- 
Meelis Roos (mroos@linux.ee)
