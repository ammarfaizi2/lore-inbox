Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTJTRHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTJTRHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:07:21 -0400
Received: from gprs147-166.eurotel.cz ([160.218.147.166]:46208 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262629AbTJTRHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:07:20 -0400
Date: Mon, 20 Oct 2003 19:07:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Kill unneccessary debug printk
Message-ID: <20031020170704.GA422@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This printk is unneccessary for quite a long time, please kill it. [I
added it, so it should be okay for me to request it being killed..]

								Pavel

iIndex: arch/i386/kernel/setup.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/arch/i386/kernel/setup.c,v
retrieving revision 1.100
diff -u -r1.100 setup.c
--- clean/arch/i386/kernel/setup.c	1 Oct 2003 17:30:14 -0000	1.100
+++ linux/arch/i386/kernel/setup.c	20 Oct 2003 16:57:58 -0000
@@ -964,7 +964,6 @@
 	apm_info.bios = APM_BIOS_INFO;
 	ist_info = IST_INFO;
 	saved_videomode = VIDEO_MODE;
-	printk("Video mode to be used for restore is %lx\n", saved_videomode);
 	if( SYS_DESC_TABLE.length != 0 ) {
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
 		machine_id = SYS_DESC_TABLE.table[0];

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
