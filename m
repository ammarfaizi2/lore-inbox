Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161235AbWHDOk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbWHDOk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWHDOk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:40:59 -0400
Received: from mx.melware.net ([217.91.97.190]:5641 "EHLO mx.melware.net")
	by vger.kernel.org with ESMTP id S1161235AbWHDOk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:40:58 -0400
Date: Fri, 4 Aug 2006 16:40:37 +0200 (CEST)
From: Armin Schindler <armin@melware.de>
X-X-Sender: armin@phoenix.one.melware.de
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eicon: fix define conflict with ptrace
In-Reply-To: <20060803203411.GB6828@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.61.0608041636580.9061@phoenix.one.melware.de>
References: <20060803203411.GB6828@martell.zuzino.mipt.ru>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If that define is now used somewhere else, it can be removed from the Eicon 
driver, because it isn't really used at this time.

Armin

On Fri, 4 Aug 2006, Alexey Dobriyan wrote:
* MODE_MASK is unused in eicon driver.
* Conflicts with a ptrace stuff on arm.

drivers/isdn/hardware/eicon/divasync.h:259:1: warning: "MODE_MASK" redefined
include2/asm/ptrace.h:48:1: warning: this is the location of the previous definition

Acked-by: Armin Schindler <armin@melware.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/isdn/hardware/eicon/divasync.h |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/isdn/hardware/eicon/divasync.h
+++ b/drivers/isdn/hardware/eicon/divasync.h
@@ -256,7 +256,6 @@ #define WATCHDOG_MASK  0x00000008
 #define NO_ORDER_CHECK_MASK 0x00000010
 #define LOW_CHANNEL_MASK 0x00000020
 #define NO_HSCX30_MASK  0x00000040
-#define MODE_MASK   0x00000080
 #define SET_BOARD   0x00001000
 #define SET_CRC4   0x00030000
 #define SET_L1_TRISTATE  0x00040000

