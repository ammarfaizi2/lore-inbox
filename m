Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269335AbUINLrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269335AbUINLrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269315AbUINLp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:45:58 -0400
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:49295 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269282AbUINLpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:45:22 -0400
Message-ID: <4146DA0D.3050407@246tNt.com>
Date: Tue, 14 Sep 2004 13:46:21 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/9] Small updates for Freescale MPC52xx
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
#   2004/09/13 21:04:47+02:00 tnt@246tNt.com
#   ppc: Update name of Freescale MPC52xx platform (IceCube -> LITE5200)
#   
#   The official name is LITE5200, so we take this one for comments and
#   functions names.
#   
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/platforms/lite5200.c
#   2004/09/13 21:04:17+02:00 tnt@246tNt.com +5 -6
#   ppc: Update name of Freescale MPC52xx platform (IceCube -> LITE5200)
#
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c     2004-09-14 12:47:23 +02:00
+++ b/arch/ppc/platforms/lite5200.c     2004-09-14 12:47:23 +02:00
@@ -71,16 +71,15 @@
 /* 
======================================================================== */

 static int
-icecube_show_cpuinfo(struct seq_file *m)
+lite5200_show_cpuinfo(struct seq_file *m)
 {
        seq_printf(m, "machine\t\t: Freescale LITE5200\n");
        return 0;
 }

 static void __init
-icecube_setup_arch(void)
+lite5200_setup_arch(void)
 {
-
        /* Add board OCP definitions */
        mpc52xx_add_board_devices(board_ocp);
 }
@@ -126,8 +125,8 @@
        isa_mem_base            = 0;

        /* Setup the ppc_md struct */
-       ppc_md.setup_arch       = icecube_setup_arch;
-       ppc_md.show_cpuinfo     = icecube_show_cpuinfo;
+       ppc_md.setup_arch       = lite5200_setup_arch;
+       ppc_md.show_cpuinfo     = lite5200_show_cpuinfo;
        ppc_md.show_percpuinfo  = NULL;
        ppc_md.init_IRQ         = mpc52xx_init_irq;
        ppc_md.get_irq          = mpc52xx_get_irq;
@@ -139,7 +138,7 @@
        ppc_md.power_off        = mpc52xx_power_off;
        ppc_md.halt             = mpc52xx_halt;

-               /* No time keeper on the IceCube */
+               /* No time keeper on the LITE5200 */
        ppc_md.time_init        = NULL;
        ppc_md.get_rtc_time     = NULL;
        ppc_md.set_rtc_time     = NULL;

