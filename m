Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290328AbSAPBa6>; Tue, 15 Jan 2002 20:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290349AbSAPBau>; Tue, 15 Jan 2002 20:30:50 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:17796 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S290328AbSAPB3Z>; Tue, 15 Jan 2002 20:29:25 -0500
Date: Wed, 16 Jan 2002 01:30:39 +0000
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.3-pre1 compile error
Message-ID: <20020116013039.A31653@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another weirdo. Where did this come from ??

(davej@noodles:linux-2.5.3-pre1)$ rgrep isa_bus_to_virt * | wc -l
		      1

diff -u --recursive --new-file v2.5.2/linux/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- v2.5.2/linux/drivers/video/vesafb.c	Mon Jan 14 18:25:10 2002
+++ linux/drivers/video/vesafb.c	Tue Jan 15 10:56:35 2002
@@ -550,7 +550,7 @@
 		ypan = pmi_setpal = 0; /* not available or some DOS TSR ... */
 
 	if (ypan || pmi_setpal) {
-		pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
+		pmi_base  = (unsigned short*)isa_bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
 		pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
 		pmi_pal   = (void*)((char*)pmi_base + pmi_base[2]);
 		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
