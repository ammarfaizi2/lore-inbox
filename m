Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312494AbSCUVGp>; Thu, 21 Mar 2002 16:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312496AbSCUVGg>; Thu, 21 Mar 2002 16:06:36 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:20955 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S312495AbSCUVGT>; Thu, 21 Mar 2002 16:06:19 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 21 Mar 2002 13:06:14 -0800
Message-Id: <200203212106.NAA25987@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.7 BUG() calls in slab.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Under 2.5.7, running fsck on a 40GB disk partition (with
perhaps 10GB in use) would reliably create a kernel BUG() call
from slab.c at either line 1463 or line 1467, apparently due to
a call to shrink_icache_memory (a few levels up the call stack).
The disk drive is IDE.

	Because this particular partition was a scratch area,
I was able to work around the problem by doing an mkfs on the
offending partition.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
