Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWBFNiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWBFNiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWBFNiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:38:02 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42221 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932082AbWBFNh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:37:59 -0500
Date: Mon, 06 Feb 2006 22:37:08 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Brown, Len" <len.brown@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       naveen.b.s@intel.com
Subject: [RFC:PATCH(000/003)] Memory add to onlined node.
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.062
Message-Id: <20060206221815.0605.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I would like to post patches for memory hot-add.
Current code allow addition to just node 0.
By this patch, the new memory is able to be added to appropriate node,
- if the node is already online.-  If the node is offline, 
(It means new node is comming!)  then the memory will belongs
to node 0 yet.

If new memory belongs to new node, new pgdat must be initialized.
But, it still need more many steps. So, I would like to propose
this small steps for a while.

This patch is use acpi's DSDT to fined node id from physicall address.
So, this patch is just for intel/AMD architecture.

I tested this patch on ia64, and confirm copile completion for x86_64.
If there is no objection, I would like to test it too.

This patch is for 2.6.16-rc1-mm5. -mm5 already has pxm_to_nid map's
clean up and add_memory for x86_64. 
So, these patches could be small. :-)

Please comment.

-- 
Yasunori Goto 


