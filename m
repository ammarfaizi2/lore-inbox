Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270557AbRHXC1l>; Thu, 23 Aug 2001 22:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270630AbRHXC1b>; Thu, 23 Aug 2001 22:27:31 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:16110 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S270557AbRHXC1P>; Thu, 23 Aug 2001 22:27:15 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 23 Aug 2001 19:27:29 -0700
Message-Id: <200108240227.TAA12503@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Remove net_dev_init from linux-2.4.9/drivers/block/genhd.c?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.4.9/drivers/block/genhd.c contains a call to
net_dev_init, which appears to be unnecessary, because net_dev_init
will be called automatically by the first call to register_netdevice
if net_dev_init has not already been called (register_netdevice is
in net/core/dev.c).  So, I just removed the call to net_dev_init
from drivers/block/genhd.c, and the resulting system seem to be
work fine, but I thought I ought to ask if anyone sees a specific
problem with doing this, and if that problem would be avoided by
just putting a "module_init(net_dev_init);" line at the bottom of
net/core/dev.c.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
