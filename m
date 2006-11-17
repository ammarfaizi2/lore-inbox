Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162357AbWKQEvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162357AbWKQEvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 23:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162355AbWKQEvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 23:51:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:53950 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1162350AbWKQEvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 23:51:52 -0500
Subject: m68knommu doesn't build upstream
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-m68k@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 15:51:44 +1100
Message-Id: <1163739105.5940.431.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking into getting rid of the old compat dma-mapping stuff,
which is only used by a handful of archs, I've built some cross
toolchains for those archs in order to at least test build my changes.

It looks however that one of them, m68knommu, doesn't build with
upstream git and a defconfig

 In file included from arch/m68knommu/kernel/asm-offsets.c:18:
include/asm/irqnode.h:26: error: conflicting types for 'irq_handler_t'
include/linux/interrupt.h:67: error: previous declaration of 'irq_handler_t' was here

Is this arch bitrotting ?

Cheers,
Ben.


