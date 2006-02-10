Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWBJOU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWBJOU7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWBJOU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:20:58 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:10896 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932105AbWBJOU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:20:57 -0500
Date: Fri, 10 Feb 2006 23:20:29 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Subject: [RFC/PATCH: 000/010] Memory hotplug for new nodes with pgdat allocation.
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060210223636.C52E.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'll post newest patches for memory hotadd.
In this this patch, pgdat is allocated when new node is comming.
To initialize pgdat and zones, a set of patches are necessary.
  - to allcate and initialize pgdat, zone, zonelist.
  - to initialize node_data[] array (ia64)
  - to register sysfs file for new node.
  - to call memory_hotplug code from acpi container driver.

Note:
 - kmalloc is used for pgdat allocation in this version.
   So, even if pgdat is allocated, it will be allocated on the other node.
   This is only to simplify patches a bit. :-P
 - register sysfs file for new node is just for ia64.
   I hacked quickly for x86_64, but x86_64 doesn't use sysfs file
   for node. So, I gave up at least this week.....


This patches are for 2.6.16-rc2-mm1.

Please comment.

Thanks.
-- 
Yasunori Goto 


