Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWELKbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWELKbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWELKbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:31:25 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:33742
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751085AbWELKbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:31:25 -0400
X-Mailbox-Line: From mb@bu3sch.de Fri May 12 12:36:47 2006
Message-Id: <20060512103522.898597000@bu3sch.de>
User-Agent: quilt/0.45-1
Date: Fri, 12 May 2006 12:35:22 +0200
From: mb@bu3sch.de
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 0/9] New Generic HW RNG (#3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series replaces the old non-generic Hardware Random Number Generator support by a fully generic RNG API.

This makes it possible to register additional RNGs from modules. With this patch series applied, Laptops with
a bcm43xx chip (PowerBook) have a HW RNG available now.

Additionally two new RNG drivers are added for the "ixp4xx" and "omap" devices. (Written by Deepak Saxena).
This patch series includes the old patches by Deepak Saxena.

The old x86-rng driver has beed splitted.

The userspace RNG daemon can later be updated to select the RNG through /sys/class/misc/hw_random/ for convenience. For now it is sufficient to use cat and echo -n on the sysfs attributes.

Please apply to -mm for testing.

