Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUIAA7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUIAA7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUIAA4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:56:53 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:37840 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S269020AbUHaTbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:31:25 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Tue, 31 Aug 2004 21:33:40 +0200
User-Agent: KMail/1.6.2
Cc: adaplas@pol.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408312133.40039.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent changes in frame buffer code seems to affect performance of 
scrolling on my system:

Voodoo Banshee (tdfxfb)

CONFIG:
#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y


Tests with "linux/MAINTAINERS" (time cat MAINTAINERS)
2.6.8.1
	real    0m2.625s
	user    0m0.000s
	sys     0m2.621s

2.6.9-rc1
	real    0m13.528s
	user    0m0.000s
	sys     0m13.553s


Also many -mm kernels are affected... this is obvious because these patches 
come from Andrew's tree ;-)

Any ideas?

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.9-rc1)
