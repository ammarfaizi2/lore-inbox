Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269359AbUINLyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269359AbUINLyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUINLxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:53:02 -0400
Received: from outmx015.isp.belgacom.be ([195.238.2.87]:15282 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269327AbUINLtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:49:36 -0400
Message-ID: <4146DB13.1090909@246tNt.com>
Date: Tue, 14 Sep 2004 13:50:43 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/9] Small updates for Freescale MPC52xx
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/14 00:07:12+02:00 tnt@246tNt.com
#   ppc: Use interactive console for Freescale MPC52xx when using 
boot/simple
#  
#   Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
#   Signed-off-by: Sylvain Munaut <tnt246tNt.com>
#
# arch/ppc/boot/simple/misc.c
#   2004/09/14 00:07:01+02:00 tnt@246tNt.com +3 -1
#   ppc: Use interactive console for Freescale MPC52xx when using 
boot/simple
#
diff -Nru a/arch/ppc/boot/simple/misc.c b/arch/ppc/boot/simple/misc.c
--- a/arch/ppc/boot/simple/misc.c       2004-09-14 12:47:44 +02:00
+++ b/arch/ppc/boot/simple/misc.c       2004-09-14 12:47:44 +02:00
@@ -48,7 +48,9 @@
  * Val Henson has requested that Gemini doesn't wait for the
  * user to edit the cmdline or not.
  */
-#if (defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_VGA_CONSOLE)) \
+#if (defined(CONFIG_SERIAL_8250_CONSOLE) \
+       || defined(CONFIG_VGA_CONSOLE) \
+       || defined(CONFIG_SERIAL_MPC52xx_CONSOLE)) \
        && !defined(CONFIG_GEMINI)
 #define INTERACTIVE_CONSOLE    1
 #endif

