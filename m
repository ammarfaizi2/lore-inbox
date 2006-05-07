Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWEGOiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWEGOiS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 10:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWEGOiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 10:38:18 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:9445
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750883AbWEGOiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 10:38:17 -0400
X-Mailbox-Line: From mb@pc1 Sun May  7 16:42:56 2006
Message-Id: <20060507143806.465264000@pc1>
Date: Sun, 07 May 2006 16:38:06 +0200
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 0/6] New Generic HW RNG (#2)
From: Michael Buesch <mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second try. Various fixes included. This does even compile (and work) now. :)

This patch series replaces the old non-generic Hardware Random Number Generator support by a fully generic RNG API.

This makes it possible to register additional RNGs from modules. With this patch series applied, Laptops with
a bcm43xx chip (PowerBook) have a HW RNG available now.

Additionally two new RNG drivers are added for the "ixp4xx" and "omap" devices. (Written by Deepak Saxena).
This patch series includes the old patches by Deepak Saxena.

The x86-rng driver is the old RNG driver ported to the new API (and cleaned up a bit).

The userspace RNG daemon can later be updated to select the RNG through /sys/class/misc/hw_random/ for convenience. For now it is sufficient to use cat and echo -n on the sysfs attributes.

Please apply to -mm for testing.

