Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWHCUeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWHCUeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWHCUeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:34:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:675 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751319AbWHCUeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:34:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ElVHgAG2RkRcVRCfkf4f6b+BMffOgooDJiyu8SvuV4iUaQN2O+XsuVe4NW3c7htH5NiTVKVzCfyQyNlx1DqhdfukESuzC8LhWGuIlDJpDy9lJmpKWY9SShsAir21EJw9O77qkzgYu5Xkg9/1ABAHdZOVy0HIYgo/Omy6CAtW+ys=
Date: Fri, 4 Aug 2006 00:34:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Armin Schindler <mac@melware.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] eicon: fix define conflict with ptrace
Message-ID: <20060803203411.GB6828@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* MODE_MASK is unused in eicon driver.
* Conflicts with a ptrace stuff on arm.

drivers/isdn/hardware/eicon/divasync.h:259:1: warning: "MODE_MASK" redefined
include2/asm/ptrace.h:48:1: warning: this is the location of the previous definition

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

