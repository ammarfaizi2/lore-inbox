Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269369AbUINMAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269369AbUINMAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269365AbUINL6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:58:38 -0400
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:55209 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269282AbUINLtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:49:09 -0400
Message-ID: <4146DAEC.1040107@246tNt.com>
Date: Tue, 14 Sep 2004 13:50:04 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/9] Small updates for Freescale MPC52xx
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/14 00:02:45+02:00 tnt@246tNt.com
#   ppc: Use dummy_con for conswitchp on Freescale MPC52xx platforms
#  
#   Apparently needed for when virtual consoles are enabled.
#  
#   Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
#   Signed-off-by: Sylvain Munaut <tnt246tNt.com>
#
# arch/ppc/platforms/lite5200.c
#   2004/09/14 00:02:31+02:00 tnt@246tNt.com +4 -0
#   ppc: Use dummy_con for conswitchp on Freescale MPC52xx platforms
#
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c     2004-09-14 12:47:37 +02:00
+++ b/arch/ppc/platforms/lite5200.c     2004-09-14 12:47:37 +02:00
@@ -147,5 +147,9 @@
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
        ppc_md.progress         = mpc52xx_progress;
 #endif
+
+#ifdef CONFIG_DUMMY_CONSOLE
+       conswitchp = &dummy_con;
+#endif
 }


