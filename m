Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUIECzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUIECzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUIECzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:55:19 -0400
Received: from [61.48.52.95] ([61.48.52.95]:25587 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S266136AbUIECzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:55:14 -0400
Date: Sun, 5 Sep 2004 10:49:53 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200409051749.i85Hnrx03529@freya.yggdrasil.com>
To: airlied@linux.ie, faith@valinux.com
Subject: linux-2.6.9-rc1-bk11/driver/char/drm/gamma_drm.c does not compile
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	drivers/char/drm/gramm_drm.c compiled under bk10, but fails
to compile under bk11.  I think the bad patch was "DRM initial function
table support", at the URL
http://marc.theaimsgroup.com/?l=linux-kernel&m=109395880025924&w=2 .

	It looks like gamma_driver_register_fns() tries to set some
nonexistant fields in dev->fn_tbl to point to some nonexistant
subroutines.  I would guess that the lines from gamma_dma.c can just
be deleted, but perhaps this compile error indicates some more
substantial version skew. 

drivers/char/drm/gamma_dma.c: In function `gamma_driver_register_fns':
drivers/char/drm/gamma_dma.c:943: error: structure has no member named `dma_flush_block_and_flush'
drivers/char/drm/gamma_dma.c:944: error: structure has no member named `dma_flush_unblock'

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
