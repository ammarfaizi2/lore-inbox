Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269363AbUINL5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269363AbUINL5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUINLyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:54:41 -0400
Received: from outmx004.isp.belgacom.be ([195.238.2.101]:5305 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269342AbUINLx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:53:26 -0400
Message-ID: <4146DBEF.60803@246tNt.com>
Date: Tue, 14 Sep 2004 13:54:23 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/9] Small updates for Freescale MPC52xx
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
#   2004/09/14 00:25:36+02:00 tnt@246tNt.com
#   ppc: Fix spurious iounmap in Freescale MPC52xx syslib
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/09/14 00:25:27+02:00 tnt@246tNt.com +0 -2
#   ppc: Fix spurious iounmap in Freescale MPC52xx syslib
#
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c 
b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c   2004-09-14 12:47:51 +02:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c   2004-09-14 12:47:51 +02:00
@@ -148,8 +148,6 @@
                if (((sdram_config_1 & 0x1f) >= 0x13) &&
                                ((sdram_config_1 & 0xfff00000) == ramsize))
                        ramsize += 1 << ((sdram_config_1 & 0xf) + 17);
-
-               iounmap(mmap_ctl);
        }

        return ramsize;

