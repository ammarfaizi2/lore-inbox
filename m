Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUIFDid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUIFDid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUIFDid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 23:38:33 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:41394
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267413AbUIFDib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 23:38:31 -0400
Date: Sun, 5 Sep 2004 20:36:22 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] DRM remove DMA/IRQ macros..
Message-Id: <20040905203622.32f75496.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0409051015570.14009@skynet>
References: <Pine.LNX.4.58.0409051015570.14009@skynet>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004 10:21:34 +0100 (IST)
Dave Airlie <airlied@linux.ie> wrote:

> 	The attached patch dumps the DMA/IRQ macros, I've realised I one
> more to go after this for some macros from the ffb driver,


Speaking of the ffb driver, you broke the build of
it pretty seriously 2 days ago, please fix.  Thanks.

drivers/char/drm/ffb_drv.c: At top level:
drivers/char/drm/ffb_drv.c:296: warning: `ffb_presetup' defined but not used
drivers/char/drm/ffb_drv.c:179: warning: `ffb_count_card_instances' defined but not used
  CC [M]  drivers/char/drm/ffb_context.o
drivers/char/drm/ffb_context.c: In function `ffb_driver_presetup':
drivers/char/drm/ffb_context.c:559: warning: implicit declaration of function `ffb_presetup'
drivers/char/drm/ffb_context.c:560: error: `_ret' undeclared (first use in this function)
drivers/char/drm/ffb_context.c:560: error: (Each undeclared identifier is reported only once
drivers/char/drm/ffb_context.c:560: error: for each function it appears in.)
drivers/char/drm/ffb_context.c: In function `ffb_driver_postcleanup':
drivers/char/drm/ffb_context.c:570: error: `ffb_position' undeclared (first use in this function)
drivers/char/drm/ffb_context.c: In function `ffb_driver_kernel_context_switch_unlock':
drivers/char/drm/ffb_context.c:580: error: `lock' undeclared (first use in this function)
drivers/char/drm/ffb_context.c: At top level:
drivers/char/drm/ffb_context.c:591: warning: static declaration for `ffb_driver_register_fns' follows non-static
drivers/char/drm/ffb_context.c: In function `ffb_driver_register_fns':
drivers/char/drm/ffb_context.c:593: warning: assignment from incompatible pointer type
drivers/char/drm/ffb_context.c:596: warning: assignment from incompatible pointer type
drivers/char/drm/ffb_context.c: At top level:
drivers/char/drm/ffb_context.c:591: warning: `ffb_driver_register_fns' defined but not used
