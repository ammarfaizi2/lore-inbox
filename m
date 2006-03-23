Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWCWNl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWCWNl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCWNl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:41:56 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:50391 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751201AbWCWNlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:41:55 -0500
Date: Thu, 23 Mar 2006 22:41:05 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 000/002] Catch notification of memory add event of ACPI via container driver.
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060323221810.8A0B.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

These 2 patches are to catch notification of new node's hot-add event via ACPI.

They were members of v4 of new node hot-add patches.
However, I would like to merge them at first before other patch.
Because, if these 2 patches are merged into mainline, all new node's memory
can be added to node 0. If not, no memory is added even if other patches are
merged. In addition, there is no opposition to these patches.

To tell the truth, I've posted similer patches a few times to ACPI-ML.
But, unfortunately, there was no response.

So, could you apply these patches to -mm tree? 

This patch is for 2.6.16-mm1.
I tested on my ia64 Tiger4 box with my node emulation. 
In addition, our firmware team provided us new firmware which can allow hot-add.
These patches worked well on it. :-)

Bye.

------------------------------------------

These 2 patches are to catch notification of new node's hot-add event
via ACPI.
If a new node is added, notification of ACPI reaches container device
which means node, and container driver scans belonging devices.
To call memory device's driver, start function of acpi memory device is
necessary. First patch is to register its function.

In addition, the scanning of memory devices and call add_memory() works 
even if memory is registered at boottime. 
Second patch is to avoid redundant call of add_memory().

-- 
Yasunori Goto 


