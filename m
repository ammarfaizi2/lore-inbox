Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUKOEgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUKOEgx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbUKOEgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 23:36:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36255 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261422AbUKOEgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 23:36:52 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Andries.Brouwer@cwi.nl
Subject: 2.6.10-rc2 dm.c dm_init unresolved reference to _exits
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Nov 2004 15:36:21 +1100
Message-ID: <27983.1100493381@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 build, gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-24)

CONFIG_BLK_DEV_DM=y
CONFIG_HOTPLUG=n

drivers/md/dm.c dm_int refers to _exits which is defined as __exitdata.
With CONFIG_HOTPLUG=n, __exitdata is discarded by arch/ia64/kernel/vmlinux.lds.S.

drivers/built-in.o(.init.text+0x1f720): In function `dm_init':
: undefined reference to `_exits'
drivers/built-in.o(.init.text+0x1f730): In function `dm_init':
: undefined reference to `_exits'

