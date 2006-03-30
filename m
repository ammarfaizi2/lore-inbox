Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWC3CDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWC3CDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWC3CDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:03:05 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43975 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751434AbWC3CDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:03:04 -0500
Date: Thu, 30 Mar 2006 11:02:53 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:000/011] Configureable NODES_SHIFT
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch set is to make configurable node's number.

Current implementation defines NODES_SHIFT at include/asm-xxx/numnodes.h
for each arch. Its definition is sometimes plural.
Indeed, ia64 defines 5 NODES_SHIFT at newest git tree.
But it looks a bit messy.

SGI-SN2(ia64) system requires 1024 nodes, 
and the number of nodes already has been changeable by config.
Suitable node's number may be changed in the future even if 
it is other architecture. So, I wrote configurable node's number.

This patch set defines just default value for each arch which needs
multi nodes except ia64. 
But, it is easy to change to configurable if necessary.

This patch is for 2.6.16-git16.

See also:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114358010523896&w=2

Thanks.

P.S. I divided this patch from pxm to node id mapping.
     It will be posted later...
-- 
Yasunori Goto 


