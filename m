Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWEZGjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWEZGjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 02:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWEZGjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 02:39:23 -0400
Received: from mga07.intel.com ([143.182.124.22]:63653 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751296AbWEZGjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 02:39:23 -0400
X-IronPort-AV: i="4.05,175,1146466800"; 
   d="scan'208"; a="41886873:sNHT12684861"
Subject: pci_walk_bus race condition
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1148625315.4377.518.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 26 May 2006 14:35:16 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_walk_bus has a race with pci_destroy_dev. In the while loop,
when the callback function is called, dev pointed by next might be
freed and erased. So later on access to dev might cause kernel panic.

Yanmin
