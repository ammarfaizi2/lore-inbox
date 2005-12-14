Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVLNSdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVLNSdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVLNSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:33:33 -0500
Received: from smtp1.xandros.com ([209.87.236.18]:48034 "EHLO xandros.com")
	by vger.kernel.org with ESMTP id S932157AbVLNSdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:33:32 -0500
Message-ID: <43A06578.9080302@xandros.com>
Date: Wed, 14 Dec 2005 13:33:28 -0500
From: Woody Suwalski <woodys@xandros.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20051213 SeaMonkey/1.5a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, rmk@arm.linux.org.uk
Subject: [PATCH] ARM: Netwinder ds1620 driver needs an export to be built
 as module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# Kernel 2.6.14+
# The ds1620 module is using gpio_read symbol, so works only if "built-in"
# The symbol needs to be exported from the kernel image
#
# Woody Suwalski
# woodys@xandros.com


Signed-off-by: Woody Suwalski <woodys@xandros.com>

--- a/arch/arm/mach-footbridge/netwinder-hw.c   2005-11-04 
09:15:21.000000000 -0500
+++ b/arch/arm/mach-footbridge/netwinder-hw.c   2005-11-04 
09:17:00.000000000 -0500
@@ -601,6 +601,7 @@ EXPORT_SYMBOL(gpio_lock);
  EXPORT_SYMBOL(gpio_modify_op);
  EXPORT_SYMBOL(gpio_modify_io);
  EXPORT_SYMBOL(cpld_modify);
+EXPORT_SYMBOL(gpio_read);

  /*
   * Initialise any other hardware after we've got the PCI bus


-- 
Xandros Corporation
Simple. Powerful. Linux.
Visit us at http://www.xandros.com
