Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTKVUsf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 15:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTKVUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 15:48:34 -0500
Received: from [64.5.56.18] ([64.5.56.18]:3297 "EHLO pico.surpasshosting.com")
	by vger.kernel.org with ESMTP id S262765AbTKVUsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 15:48:32 -0500
Date: Sat, 22 Nov 2003 14:48:28 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: linux-kernel@vger.kernel.org
Subject: bugme #1217: "Use PCI DMA by default when available" does not work
Message-ID: <20031122204828.GE1411@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pico.surpasshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cheney.cx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent the following followup report to the bug I filed at
bugme.osdl.org several months ago about my hpt372 ide controller being
slow.

I have determined what causes the dramatic slowdown problem. It is not
drive specific but it may be specific to the hpt controllers. The
problem is due to using automatic dma. If I don't have the following
two options set in my kernel then it runs at full speed when I turn on
dma with hdparm. Otherwise using automatic dma I get somewhere between
a 50% - 700% slowdown on writes, reads seem to not be as badly affected.
This is reproducible on both 2.4.23-rc1-xfs and 2.6.0-test9-bk24 (the
two I tested on).

CONFIG_IDEDMA_PCI_AUTO=3Dy=20
CONFIG_IDEDMA_AUTO=3Dy=20


Chris Cheney
