Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVBQRv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVBQRv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVBQRv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:51:59 -0500
Received: from it4systems-kln-gw.de.clara.net ([212.6.222.118]:63460 "EHLO
	frankbuss.de") by vger.kernel.org with ESMTP id S262261AbVBQRvv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:51:51 -0500
From: "Frank Buss" <fb@frank-buss.de>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with dma_mmap_writecombine on mach-pxa
Date: Thu, 17 Feb 2005 18:51:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcUVGVqQIe7uf2cJTqWkVtTfTvvP3Q==
Message-Id: <20050217175150.D8E015B874@frankbuss.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use the pxafb driver on mach-pxa, but I can't mmap the
framebuffer memory. I can access it from the driver, filling the entire
screen, but when I access the pointer returned from mmap from a user space
program, the following two things happens:

- the vm_pgoff is ignored and I get the start of the internal buffer, which
caused writing to the palette and DMA descriptors

- when I change the location of the framebuffer to the start of the internal
buffer, I can write to the screen, but only to the first 4 k; any write
after this address is ignored, but no segfault is generated.

Any ideas what I can do to find the reason? I don't think that it is a
kernel bug, but perhaps a wrong configuration for my platform.

-- 
Frank Buﬂ, fb@frank-buss.de
http://www.frank-buss.de, http://www.it4-systems.de

