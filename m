Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263230AbVFXJXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbVFXJXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 05:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbVFXJXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 05:23:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62987 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263141AbVFXJTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 05:19:55 -0400
Date: Fri, 24 Jun 2005 10:19:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Finding what change broke ARM
Message-ID: <20050624101951.B23185@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building current git for ARM, I see:

  CC      arch/arm/mm/consistent.o
arch/arm/mm/consistent.c: In function `dma_free_coherent':
arch/arm/mm/consistent.c:357: error: `mem_map' undeclared (first use in this function)
arch/arm/mm/consistent.c:357: error: (Each undeclared identifier is reported only once
arch/arm/mm/consistent.c:357: error: for each function it appears in.)
make[2]: *** [arch/arm/mm/consistent.o] Error 1

How can I find what change elsewhere in the kernel tree caused this
breakage?

With bk, you could ask for a per-file revision history of the likely
candidates, and then find the changeset to view the other related
changes.

With git... ?  We don't have per-file revision history so...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
