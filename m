Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTFDTjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTFDTjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:39:49 -0400
Received: from catfish.lcs.mit.edu ([18.111.0.152]:4328 "EHLO
	catfish.lcs.mit.edu") by vger.kernel.org with ESMTP id S263945AbTFDTjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:39:48 -0400
Date: Wed, 4 Jun 2003 15:53:18 -0400 (EDT)
From: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: BUG_ON() in drivers/ide/ide-disk.c:1526.
Message-ID: <Pine.GSO.4.10.10306041550510.2442-100000@catfish.lcs.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using suspend-to-disk, I trigger BUG_ON in ide-disk.c:1526:

	BUG_ON (HWGROUP(drive)->handler);

It seems that this assertion is intended to check that all interrupts have
been handled before idedisk_suspend returns --- but I can't find any code
which ought to do this.

More details available if needed.
 --scott

Mk 48 assassination politics FSF EZLN spy Marxist interception Nazi 
Hussein RNC shotgun cracking COBRA JUDY ammunition COBRA JANE chemical agent 
                         ( http://cscott.net/ )

