Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287322AbSAGWwD>; Mon, 7 Jan 2002 17:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287332AbSAGWvx>; Mon, 7 Jan 2002 17:51:53 -0500
Received: from kc.hitachisoftware.com ([205.158.62.105]:10982 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S287322AbSAGWvo>; Mon, 7 Jan 2002 17:51:44 -0500
Message-ID: <20020107225138.29601.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Rudmer van Dijk" <rudmer@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 08 Jan 2002 06:51:38 +0800
Subject: [PATCH][2.5.2-pre9] fix ramdisk compile failure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for some time I was not able to compile a kernel with ramdisk support but with the following patch it works again!

rudmer

diff -u arch/i386/kernel/setup.c~ arch/i386/kernel/setup.c
--- arch/i386/kernel/setup.c~   Mon Jan  7 21:47:51 2002
+++ arch/i386/kernel/setup.c    Mon Jan  7 23:38:45 2002
@@ -661,6 +661,9 @@
        unsigned long bootmap_size, low_mem_size;
        unsigned long start_pfn, max_low_pfn;
        int i;
+#ifdef CONFIG_BLK_DEV_RAM
+       extern int rd_size, rd_image_start, rd_prompt, rd_doload;
+#endif
 
 #ifdef CONFIG_VISWS
        visws_get_board_type_and_rev();
-- 

Get your free email from www.linuxmail.org 


Powered by Outblaze
