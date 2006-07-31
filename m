Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWGaNz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWGaNz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWGaNz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:55:27 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:41182 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932247AbWGaNz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:55:27 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Mon, 31 Jul 2006 15:55:15 +0200
Message-Id: <1154354115351-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

I'm back from vacation, so I figured I should try to compile the latest
-mm for AVR32. It failed immediately, so here's a set of patches to fix
the breakage. I guess I should have tried a clean build before
submitting the last update, as I would have noticed that
include/config/MARKER doesn't exist anymore.

Anyway, 2.6.18-rc2-mm1 boots successfully on my target with these
patches, but there's something strange going on with NFS and a few
other things that I didn't notice on 2.6.18-rc1. I'll investigate
some more and see if I can figure out what's going on.

Do you want me to keep sending incremental patches, by the way? I can
fold everything (or at least the trivial stuff) into avr32-arch.patch
if you want.

Here's a shortlog of the patches coming up:
      AVR32: Use auto.conf instead of MARKER
      AVR32: Don't assume anything about MAX_NR_ZONES
      AVR32: Add nsproxy definition
      AVR32: Add I/O port access primitives
      AVR32: Use linux/pfn.h
      AVR32: Kill CONFIG_DISCONTIGMEM support completely

Haavard
