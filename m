Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbUKIFy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUKIFy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUKIFyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:54:11 -0500
Received: from motgate8.mot.com ([129.188.136.8]:43244 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261369AbUKIF15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:27:57 -0500
Date: Mon, 8 Nov 2004 23:27:48 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix rheap warning
Message-ID: <Pine.LNX.4.61.0411082325360.13565@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here is patch that fixes a compile warning with rheap

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/lib/rheap.c b/arch/ppc/lib/rheap.c
--- a/arch/ppc/lib/rheap.c	2004-11-08 22:43:52 -06:00
+++ b/arch/ppc/lib/rheap.c	2004-11-08 22:43:52 -06:00
@@ -645,6 +645,7 @@
  		return -EINVAL;

  	blk->owner = owner;
+	size = blk->size;

  	return size;
  }
