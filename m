Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933271AbWKSUvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271AbWKSUvI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933279AbWKSUvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:51:07 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:59787 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933272AbWKSUvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:51:05 -0500
Date: Sun, 19 Nov 2006 12:51:06 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rolandd@cisco.com, bos@serpentine.com
Subject: ipath uses skb functions
Message-Id: <20061119125106.0ea9541e.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

but doesn't depends on NET (Networking).

drivers/built-in.o: In function `ipath_free_pddata':
(.text.ipath_free_pddata+0x155): undefined reference to `kfree_skb'
drivers/built-in.o: In function `ipath_alloc_skb':
(.text.ipath_alloc_skb+0x28): undefined reference to `__alloc_skb'
drivers/built-in.o: In function `ipath_init_chip':
(.text.ipath_init_chip+0xe61): undefined reference to `kfree_skb'
make: *** [vmlinux] Error 1

2.6.19-rc6-git2

---
~Randy
