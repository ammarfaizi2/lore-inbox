Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUGTJSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUGTJSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 05:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUGTJSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 05:18:15 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19335 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265770AbUGTJSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 05:18:13 -0400
Date: Tue, 20 Jul 2004 18:18:03 +0900
From: Fumihiro Tersawa <terasawa@pst.fujitsu.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
Subject: [PATCH] memory hotplug for ia64 (linux-2.6.7) [0/2]
Message-Id: <20040720181135.12B6.TERASAWA@pst.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I updated the memory hotplug patch for an IPF NUMA machines which
posted in April.
The patch is against linux 2.6.7 and works with memory hotplug patch
which Takahashi-san posted on July 14.


Known issues(under investigation):

- remap function may be unable to mmigrate all pages.
- unplug-node function may fail, if page size is other than 4K byte.
- kswapd doesn't terminate when a node is unplugged.

How to apply:

 1) First of all, apply patches which Takahashi-san posted on July 14
    without [15-16/16].
    *If patches of [15-16/16] are applied, compile error will occur
     on ia64.
 2) Apply this set of patches.


Thank you,
Fumihiro Terasawa.

