Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVAVASZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVAVASZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVAVARP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:17:15 -0500
Received: from waste.org ([216.27.176.166]:36999 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262633AbVAVAKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:10:04 -0500
Date: Fri, 21 Jan 2005 18:09:47 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-Id: <1.464233479@selenic.com>
Subject: [PATCH 0/8] core-small: Introduce CONFIG_CORE_SMALL from -tiny
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches introduces a new config option CONFIG_CORE_SMALL
from the -tiny tree for small systems. This series should apply
cleanly against 2.6.11-rc1-mm2.

When selected, it enables various tweaks to miscellaneous core data
structures to shrink their size on small systems. While each tweak is
fairly small, in aggregate they can save a substantial amount of
memory.

1 Add option to embedded menu
2 Collapse major names hash
3 Collapse chrdevs hash
4 Shrink PID lookup tables
5 Shrink uid hash
6 Shrink futex queue hash
7 Shrink timer lists
8 Shrink console buffer
