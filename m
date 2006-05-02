Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWEBLbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWEBLbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWEBLbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:31:12 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:28568 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964781AbWEBLbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:31:11 -0400
Date: Tue, 02 May 2006 20:30:38 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch 000/003] pgdat allocation and update for ia64 of memory hotplug.
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>, linux-mm <linux-mm@kvack.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060502201614.CF14.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

These are parts of patches for new nodes addition v4.
When new node is added, new pgdat must be allocated and initialized.
But, ia64 has copies of node_data[] on each node. So, kernel has to
allocate not only pgdat but also its copies area. and all of copies
must be updated at hot-add. These are patches for it.

This patch is for 2.6.17-rc3-mm1.

Please apply.

------------------------------------------------------------

Change log from v4 of node hot-add.
  - update for 2.6.17-rc3-mm1.

V4 of post is here.
<description>
http://marc.theaimsgroup.com/?l=linux-mm&m=114258404023573&w=2
<patches>
http://marc.theaimsgroup.com/?l=linux-mm&w=2&r=1&s=memory+hotplug+node+v.4.&q=b

-- 
Yasunori Goto 


