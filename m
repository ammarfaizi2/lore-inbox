Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264757AbTFAWpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbTFAWpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:45:18 -0400
Received: from h-64-105-35-156.SNVACAID.covad.net ([64.105.35.156]:1152 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S264755AbTFAWpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:45:12 -0400
Date: Sun, 1 Jun 2003 15:59:02 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200306012259.h51Mx2i14095@freya.yggdrasil.com>
To: linux-ide@vger.kernel.org
Subject: 2.5.70-bk[56] breaks disk partitioning with multiple IDE disks
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Disk partition under linux-2.5.70-bk[56] systems with two
IDE disks is broken.  Under these kernels, the first disk gets
the partitioning of the second disk.  Reverting drivers/ide/ide.c
to the 2.5.70-bk4 version makes the problem go away.

	However, there were other changes made to ide.c that are
probably not related to this problem, and I haven't yet analyzed the
problem enough to suggest a potentially correct patch.

	Note that I use user-level disk partition table parsing via
partx from util-linux and run ide as a loadable module.  It is
possible that other configuations might not experience this problem.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
