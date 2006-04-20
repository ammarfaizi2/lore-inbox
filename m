Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWDTKER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDTKER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWDTKER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:04:17 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:62912 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750808AbWDTKEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:04:16 -0400
Date: Thu, 20 Apr 2006 19:03:24 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch: 000/006] pgdat allocation for new node add
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Yasunori Goto <y-goto@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

These are parts of patches for new nodes addition v4.
When new node is added, new pgdat is allocated and initialized by this patch.
These includes...
  - specify node id at add_memory().
  - start kswapd for new node.
  - allocate pgdat and register its address to node_data[].

This set includes node_data[] updater for generic arch.
Ia64 has copies of node_data[] on each node.
But, this patch set doesn't include patches to update them.
I'll post them later.


This patch is for 2.6.17-rc1-mm3.

Please apply.

------------------------------------------------------------

Change log from v4 of node hot-add.
  - generic pgdat allocation is picked up.
  - update for 2.6.17-rc1-mm3.

V4 of post is here.
<description>
http://marc.theaimsgroup.com/?l=linux-mm&m=114258404023573&w=2
<patches>
http://marc.theaimsgroup.com/?l=linux-mm&w=2&r=1&s=memory+hotplug+node+v.4.&q=b



-- 
Yasunori Goto 


