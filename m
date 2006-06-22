Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbWFVTAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbWFVTAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWFVTAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:00:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:10216 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161199AbWFVTAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:00:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=EzlXx+JujHAa+zxIexRkwpq4hElsbzcZ496SNheyU4d36yg6dLN2ABLohfg81G0c1eJsn+Ij0qde3dy2xlBD3F/7r8TInWIyBLdytWIT1ZECCYoMXFEnV1BVVVYu2BgcOIX1nGNpIWh3/tpGTSpmuxfnRYrXgJvIdX/kzI6sHAg=
Message-ID: <449AE8B5.4@gmail.com>
Date: Thu, 22 Jun 2006 13:00:05 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 10/11 ] gpio-patchset-fixups: extern to header
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff.19-fix-extern-decl

Clean up the remaining bogus extern declaration, which is already in the 
corresponding header.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

---

diff -ruNp -X dontdiff -X exclude-diffs 17-mm-pre0/drivers/char/pc8736x_gpio.c 19-extern/drivers/char/pc8736x_gpio.c
--- 17-mm-pre0/drivers/char/pc8736x_gpio.c	2006-06-20 20:42:39.000000000 -0600
+++ 19-extern/drivers/char/pc8736x_gpio.c	2006-06-21 09:48:22.000000000 -0600
@@ -212,8 +212,6 @@ static void pc8736x_gpio_change(unsigned
 	pc8736x_gpio_set(index, !pc8736x_gpio_current(index));
 }
 
-extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned iminor);
-
 static struct nsc_gpio_ops pc8736x_access = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= pc8736x_gpio_configure,


