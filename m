Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWBXUMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWBXUMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBXUMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:12:24 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:42954
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932418AbWBXUMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:12:21 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <1.399206195@selenic.com>
Subject: [PATCH 0/7] inflate pt1: refactor boot-time inflate code
Date: Fri, 24 Feb 2006 14:12:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a refactored version of the lib/inflate.c:

- clean up some really ugly code
- clean up atrocities like '#include "../../../lib/inflate.c"'
- drop a ton of cut and paste code from the kernel boot
- move towards making the boot decompressor pluggable
- move towards unifying the multiple inflate implementations
- save space

I'm sending this out in three batches. This first batch is core
clean-ups without arch-specific changes.

(This work was sponsored in part by the CE Linux Forum.)
