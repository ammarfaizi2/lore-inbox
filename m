Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTKZAyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTKZAyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:54:52 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:29314
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263107AbTKZAyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:54:51 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: -test10/PPC still broken on PowerMac 8500
Message-Id: <E1AOnxb-0001nF-00@penngrove.fdns.net>
Date: Tue, 25 Nov 2003 16:55:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of these are SCSI issues and the last one makes -test10 hard to debug.

* MESH gets SLAB errors during startup, CDROM eject
* "mac53c94: module license 'unspecified' taints kernel."
* "53C94 did not call scsi_unregister" [sorry, should have filed bug report]
* 'swim3.c' doesn't compile properly
* Switching from X to text console ('controlfb' frame buffer) loses video 
  sync.

The 53C94 problems probably aren't hard to fix.  For the floppy code (that 
is, 'swim3.c'), 'benh' has a version of 'swim3' which may only need further
testing.  The MESH issue looks like a buffer alignment problem, and worked 
without complaint in the 2.4 kernels.  

The video mode problem is a real nuisance and is the biggest reason i'm not
doing more than intermittent testing of 2.6.0/PPC.

			         -- JM


P.S.  I came across a large pile of floppies during a massive cleanup (why
i've been so busy) and i can run some more tests of the 'swim3' code after 
the Thanksgiving break.
