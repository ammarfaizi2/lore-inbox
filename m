Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292478AbSBPSIF>; Sat, 16 Feb 2002 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292477AbSBPSHz>; Sat, 16 Feb 2002 13:07:55 -0500
Received: from 205-158-62-44.outblaze.com ([205.158.62.44]:42212 "EHLO
	mta1-3.us4.outblaze.com") by vger.kernel.org with ESMTP
	id <S292470AbSBPSHl>; Sat, 16 Feb 2002 13:07:41 -0500
Message-ID: <20020216180735.7807.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Rudmer van Dijk" <rudmer@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de
Date: Sun, 17 Feb 2002 02:07:35 +0800
Subject: [PATCH] 2.5.5-pre1, allow RAM disk to be build
X-Originating-Ip: 212.129.187.93
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since 2.5.x (can't remember version correctly) the setup for RAM disk changed and I could not build it anymore into the kernel due to compilation errors.
In the latest prepatch (2.5.5-pre1) this is still not fixed. I am using the following patch to fix this and it works from 2.5.x upto 2.5.5-pre1 without any problems.

please apply,

Rudmer

PS. CC me as I am not on the list

--
# diff -uN linux-2.5.5-pre1/arch/i386/kernel/setup.c.orig linux-2.5.5-pre1/arch/i386/kernel/setup.c
--- linux-2.5.5-pre1/arch/i386/kernel/setup.c.orig   Thu Feb 14 20:39:00 2002
+++ linux-2.5.5-pre1/arch/i386/kernel/setup.c   Thu Feb 14 20:40:17 2002
@@ -661,7 +661,9 @@
        unsigned long bootmap_size, low_mem_size;
        unsigned long start_pfn, max_low_pfn;
        int i;
-
+#ifdef CONFIG_BLK_DEV_RAM
+       extern int rd_image_start, rd_prompt, rd_doload;
+#endif
 #ifdef CONFIG_VISWS
        visws_get_board_type_and_rev();
 #endif

-- 

Get your free email from www.linuxmail.org 


Powered by Outblaze
